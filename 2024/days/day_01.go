package days

import (
	"aoc_2024/utils"
	"slices"
	"strconv"
)

type Day01 struct {
	listL []int
	listR []int
}

func NewDay01(path string) Solution {
	var listL, listR []int

	words := utils.ReadWords(path)
	var num int
	for i := 0; i < len(words); i += 2 {
		num, _ = strconv.Atoi(words[i])
		listL = append(listL, num)

		num, _ = strconv.Atoi(words[i+1])
		listR = append(listR, num)
	}

	if len(listL) != len(listR) {
		panic("bad size")
	}

	slices.Sort(listL)
	slices.Sort(listR)

	return &Day01{listL: listL, listR: listR}
}

func (d *Day01) Part1() string {
	var distance int

	for i := range len(d.listL) {
		diff := d.listL[i] - d.listR[i]

		if diff < 0 {
			diff = -diff
		}

		distance += diff
	}

	return strconv.Itoa(distance)
}
func (d *Day01) Part2() string {
	var similarity int
	var counter = make(map[int]int)

	for _, num := range d.listR {
		counter[num]++
	}

	for _, num := range d.listL {
		similarity += num * counter[num]
	}

	return strconv.Itoa(similarity)
}
