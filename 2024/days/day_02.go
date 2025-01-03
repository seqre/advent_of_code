package days

import (
	"aoc_2024/utils"
	"strconv"
)

type Day02 struct {
	reports [][]int
}

func NewDay02(path string) Solution {
	linesS := utils.ReadLinesOfWords(path)

	linesI := make([][]int, len(linesS))
	for i, words := range linesS {
		numbers := make([]int, len(words))
		for j, word := range words {
			numbers[j], _ = strconv.Atoi(word)
		}
		linesI[i] = numbers
	}

	return &Day02{reports: linesI}
}

func (d *Day02) Part1() string {
	var safeReports int

	for _, report := range d.reports {
		bad := check(report)

		if !bad {
			safeReports++
		}
	}

	return strconv.Itoa(safeReports)
}
func (d *Day02) Part2() string {
	var safeReports int

	for _, report := range d.reports {
		bad := check(report)

		if !bad {
			safeReports++
		} else {
			for i := range len(report) {
				subSlice := append([]int{}, report[:i]...)
				subSlice = append(subSlice, report[i+1:]...)
				bad = check(subSlice)
				if !bad {
					safeReports++
					break
				}
			}
		}
	}

	return strconv.Itoa(safeReports)
}

func check(report []int) bool {
	var inc, dec, bad bool
	var prev int

	prev = report[0]

	for _, num := range report[1:] {
		if num > prev {
			if dec {
				return true
			}
			inc = true
		}

		if num < prev {
			if inc {
				return true
			}
			dec = true
		}

		diff := num - prev
		if diff < 0 {
			diff = -diff
		}

		if diff < 1 || 3 < diff {
			return true
		}

		prev = num
	}

	return bad
}
