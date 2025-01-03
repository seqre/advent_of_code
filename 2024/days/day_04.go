package days

import (
	"aoc_2024/utils"
	"strconv"
	"strings"
)

var xmas = [4]rune{'X', 'M', 'A', 'S'}
var directionsPart1 = [8][2]int{
	{0, 1}, {1, 0}, {0, -1}, {-1, 0},
	{-1, -1}, {-1, 1}, {1, -1}, {1, 1},
}
var mmss = [4]rune{'M', 'M', 'S', 'S'}

type Day04 struct {
	grid utils.Grid[utils.Rune]
}

func NewDay04(path string) Solution {
	grid := utils.ReadGrid(path, utils.TransformRune)
	return &Day04{grid: grid}
}

func (d *Day04) Part1() string {
	var validWords int

	for x := 0; x < d.grid.MaxX; x++ {
		for y := 0; y < d.grid.MaxY; y++ {
			let := d.grid.Get(x, y, '.')

			if let != 'X' {
				continue
			}

			for _, dir := range directionsPart1 {
				if d.check1(x, y, dir[0], dir[1]) {
					validWords++
				}
			}
		}
	}
	return strconv.Itoa(validWords)
}

func (d *Day04) check1(x, y, dx, dy int) bool {
	for i := 1; i < 4; i++ {
		x += dx
		y += dy
		let := d.grid.Get(x, y, '.').ToRune()
		if let != xmas[i] {
			return false
		}
	}
	return true
}

func (d *Day04) Part2() string {
	var validMases int

	for x := 0; x < d.grid.MaxX; x++ {
		for y := 0; y < d.grid.MaxY; y++ {
			let := d.grid.Get(x, y, '.')

			if let != 'A' {
				continue
			}

			for i := 0; i < 4; i++ {
				if d.check2(x, y, i) {
					validMases++
				}
			}

		}
	}
	return strconv.Itoa(validMases)
}

func (d *Day04) check2(x, y, k int) bool {
	around := d.getAround(x, y)
	mmss := rotate(mmss, k)
	for i := 0; i < 4; i++ {
		if around[i] != mmss[i] {
			return false
		}
	}
	return true
}

func (d *Day04) getAround(x, y int) [4]rune {
	return [4]rune{
		d.grid.Get(x-1, y-1, '.').ToRune(),
		d.grid.Get(x+1, y-1, '.').ToRune(),
		d.grid.Get(x+1, y+1, '.').ToRune(),
		d.grid.Get(x-1, y+1, '.').ToRune(),
	}
}

func asString(a [4]rune) string {
	var sb strings.Builder
	sb.WriteRune(a[0])
	sb.WriteRune(a[1])
	sb.WriteRune(a[2])
	sb.WriteRune(a[3])
	return sb.String()
}

func rotate(w [4]rune, j int) [4]rune {
	var rotated [4]rune
	for i := 0; i < 4; i++ {
		idx := (j + i) % 4
		rotated[idx] = w[i]
	}
	return rotated
}
