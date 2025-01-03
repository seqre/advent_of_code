package utils

import (
	"fmt"
	"strings"
)

type Grid[T GridType[T]] struct {
	Grid       [][]T
	MaxX, MaxY int
}

func (g *Grid[T]) Get(x, y int, def T) T {
	if x < 0 || x >= g.MaxX || y < 0 || y >= g.MaxY {
		return def
	} else {
		return g.Grid[x][y]
	}
}

func (g *Grid[T]) Copy() Grid[T] {
	newGrid := CopyGrid(g.Grid)
	return Grid[T]{Grid: newGrid, MaxX: g.MaxX, MaxY: g.MaxY}
}

type GridType[T any] interface {
	ToRune() rune
}

type Rune rune

func (r Rune) ToRune() rune {
	return rune(r)
}

func TransformRune(r rune) Rune {
	return Rune(r)
}

func (g *Grid[_]) AsString() string {
	return AsString(g.Grid)
}

func AsString[T GridType[T]](g [][]T) string {
	return AsStringWithEmphasis(g, [2]int{})
}
func AsStringWithEmphasis[T GridType[T]](g [][]T, emphasis [2]int) string {
	var sb strings.Builder
	bs, be := "\u001B[1m", "\u001B[0m"
	bls := "\u001B[1;4;31m"
	//is := "\u001B[3;4m"

	sb.WriteString("    " + bs)
	for i := 0; i < len(g); i++ {
		sb.WriteString(fmt.Sprintf("%3d ", i))
	}
	sb.WriteString(be + "\n")

	for y := 0; y < len(g[0]); y++ {
		sb.WriteString(bs + fmt.Sprintf("%3d ", y) + be)
		for x := 0; x < len(g); x++ {
			char := fmt.Sprintf("%3c ", g[x][y].ToRune())
			if emphasis != [2]int{} && x == emphasis[0] && y == emphasis[1] {
				char = bls + char + be
			}
			sb.WriteString(char)
		}
		sb.WriteString("\n")
	}

	return sb.String()
}

func CopyGrid[T any](g [][]T) [][]T {
	newGrid := make([][]T, len(g))
	for i := range len(g) {
		newGrid[i] = make([]T, len(g[i]))
		copy(newGrid[i], g[i])
	}
	return newGrid
}

func InitGrid[T any](maxX, maxY int) [][]T {
	newGrid := make([][]T, maxX)
	for i := range maxX {
		newGrid[i] = make([]T, maxY)
	}
	return newGrid
}
