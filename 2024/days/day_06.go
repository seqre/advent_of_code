package days

import (
	"aoc_2024/utils"
	"strconv"
)

type Day06 struct {
	grid utils.Grid[Cell]
}

type Cell rune

func (c Cell) ToRune() rune {
	return rune(c)
}

const (
	Empty    Cell = '.'
	Obstacle      = '#'
	Visited       = 'X'
	GuardN        = '^'
	GuardE        = '>'
	GuardS        = '/'
	GuardW        = '<'
	Border        = '_'
)

func transformRuneToCell(r rune) Cell {
	switch r {
	case '#':
		return Obstacle
	case '^':
		return GuardN
	default:
		return Empty
	}
}

func NewDay06(path string) Solution {
	grid := utils.ReadGrid(path, transformRuneToCell)
	return &Day06{grid: grid}
}

func (d *Day06) Part1() string {
	var visitedFields int

	simulated := d.simulate()
	for x := 0; x < len(simulated); x++ {
		for y := 0; y < len(simulated[x]); y++ {
			if simulated[x][y] == Visited {
				visitedFields++
			}
		}
	}

	return strconv.Itoa(visitedFields)
}

func (d *Day06) findGuard() (int, int) {
	for x := 0; x < d.grid.MaxX; x++ {
		for y := 0; y < d.grid.MaxY; y++ {
			if d.grid.Grid[x][y] == GuardN {
				return x, y
			}
		}
	}
	panic("guard not found")
}

func (d *Day06) simulate() [][]Cell {
	simulated := make([][]Cell, d.grid.MaxX)
	for i := range d.grid.MaxX {
		simulated[i] = make([]Cell, d.grid.MaxY)
		copy(simulated[i], d.grid.Grid[i])
	}

	guardOnMap := true
	guardX, guardY := d.findGuard()
	newX, newY := guardX, guardY

	for guardOnMap {
		guard := simulated[guardX][guardY]
		newX, newY = d.getNextGuardMove(guard, guardX, guardY)

		//fmt.Printf("(%d,%d) -> (%d,%d)\n", guardX, guardY, newX, newY)
		newPos := d.getCell(simulated, newX, newY)

		switch newPos {
		case Empty:
			simulated[guardX][guardY] = Visited
			simulated[newX][newY] = guard
			guardX, guardY = newX, newY
		case Visited:
			simulated[guardX][guardY] = Visited
			simulated[newX][newY] = guard
			guardX, guardY = newX, newY
		case Obstacle:
			simulated[guardX][guardY] = d.rotate(guard)
		case Border:
			simulated[guardX][guardY] = Visited
			guardOnMap = false
		}

	}

	return simulated
}

func (d *Day06) getNextGuardMove(guard Cell, guardX, guardY int) (int, int) {
	switch guard {
	case GuardN:
		return guardX, guardY - 1
	case GuardE:
		return guardX + 1, guardY
	case GuardS:
		return guardX, guardY + 1
	case GuardW:
		return guardX - 1, guardY
	}
	panic("invalid guard")
}

func (_ *Day06) getCell(grid [][]Cell, x, y int) Cell {
	if x < 0 || x >= len(grid) || y < 0 || y >= len(grid[x]) {
		return Border
	} else {
		return grid[x][y]
	}
}

func (_ *Day06) rotate(guard Cell) Cell {
	switch guard {
	case GuardN:
		return GuardE
	case GuardE:
		return GuardS
	case GuardS:
		return GuardW
	case GuardW:
		return GuardN
	}
	return guard
}

type Coord [2]int

func (d *Day06) Part2() string {
	possibleLoops := make(map[Coord]struct{}, d.grid.MaxX*d.grid.MaxY)

	simulated := utils.CopyGrid(d.grid.Grid)
	pastMoves := utils.InitGrid[Cell](d.grid.MaxX, d.grid.MaxY)

	guardOnMap := true
	guardX, guardY := d.findGuard()

	for guardOnMap {
		guard := simulated[guardX][guardY]
		newX, newY := d.getNextGuardMove(guard, guardX, guardY)

		//fmt.Printf("(%d,%d) -> (%d,%d)\n", guardX, guardY, newX, newY)
		//fmt.Println(utils.AsStringWithEmphasis(simulated, [2]int{guardX, guardY}))
		newPos := d.getCell(simulated, newX, newY)

		switch newPos {
		case Empty:
			if d.checkLoop(simulated, pastMoves, guard, guardX, guardY) {
				//fmt.Println(d.getNextGuardMove(guard, guardX, guardY))
				possibleLoops[Coord{newX, newY}] = struct{}{}
			}
			simulated[guardX][guardY] = Visited
			pastMoves[guardX][guardY] = guard
			simulated[newX][newY] = guard
			guardX, guardY = newX, newY
		case Visited:
			if d.checkLoop(simulated, pastMoves, guard, guardX, guardY) {
				//fmt.Println(d.getNextGuardMove(guard, guardX, guardY))
				possibleLoops[Coord{newX, newY}] = struct{}{}
			}
			simulated[guardX][guardY] = Visited
			pastMoves[guardX][guardY] = guard
			simulated[newX][newY] = guard
			guardX, guardY = newX, newY
		case Obstacle:
			simulated[guardX][guardY] = d.rotate(guard)
		case Border:
			simulated[guardX][guardY] = Visited
			guardOnMap = false
		}

	}

	return strconv.Itoa(len(possibleLoops))
}

// 2028 too high

func (d *Day06) checkLoop(simulated, pastMoves [][]Cell, guard Cell, guardX, guardY int) bool {
	innerPastMoves := utils.CopyGrid(pastMoves)
	rotated := d.rotate(guard)
	var i int
	//fmt.Printf("Starting from %d %d\n", guardX, guardY)
	//oldX, oldY := d.getNextGuardMove(guard, guardX, guardY)

	for {
		newX, newY := d.getNextGuardMove(rotated, guardX, guardY)

		next := d.getCell(simulated, newX, newY)
		if next == Border {
			return false
		}

		past := innerPastMoves[newX][newY]
		if past == rotated {
			//fmt.Printf("Found loop at %d %d\n", oldX, oldY)
			return true
		}

		switch next {
		case Obstacle:
			rotated = d.rotate(rotated)
		default:
			innerPastMoves[guardX][guardY] = rotated
			guardX, guardY = newX, newY
		}
		i++
	}
	panic("unreachable")
}
