package days

import (
	"aoc_2024/utils"
	"fmt"
	"time"
)

type Solution interface {
	Part1() string
	Part2() string
}

var DAYS = [...]func(string) Solution{
	NewDay01,
	NewDay02,
	NewDay03,
	NewDay04,
	NewDay05,
	NewDay06,
}

func Runner(day int, sample bool) {
	if day < 0 || day > len(DAYS) {
		panic("days out of range")
	}

	path := utils.GetPath(day, sample)

	var sol = DAYS[day-1](path)
	var start time.Time

	suffix := ""
	if sample {
		suffix = "s"
	}

	start = time.Now()
	part1 := sol.Part1()
	fmt.Printf("Day %d-1%s: %s\t took %s\n", day, suffix, part1, time.Since(start).String())

	start = time.Now()
	part2 := sol.Part2()
	fmt.Printf("Day %d-2%s: %s\t took %s\n", day, suffix, part2, time.Since(start).String())

}
