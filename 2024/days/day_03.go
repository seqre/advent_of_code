package days

import (
	"aoc_2024/utils"
	"regexp"
	"strconv"
	"strings"
)

type Day03 struct {
	regex  *regexp.Regexp
	regex2 *regexp.Regexp
	data   string
}

func NewDay03(path string) Solution {
	regex, _ := regexp.Compile("mul\\([\\d]{1,3},[\\d]{1,3}\\)")
	regex2, _ := regexp.Compile("mul\\([\\d]{1,3},[\\d]{1,3}\\)|do\\(\\)|don't\\(\\)")
	data := utils.ReadAsString(path)
	return &Day03{regex: regex, regex2: regex2, data: data}
}

func (d *Day03) Part1() string {
	var mulSum int

	muls := d.regex.FindAllString(d.data, -1)
	for _, mul := range muls {
		first, second := parseMul(mul)
		mulSum += first * second
	}

	return strconv.Itoa(mulSum)
}

func (d *Day03) Part2() string {
	var mulSum int
	var do = true

	muls := d.regex2.FindAllString(d.data, -1)
	for _, mul := range muls {
		if strings.Contains(mul, "do()") {
			do = true
			continue
		}

		if strings.Contains(mul, "don't()") {
			do = false
			continue
		}

		first, second := parseMul(mul)
		if do {
			mulSum += first * second
		}
	}

	return strconv.Itoa(mulSum)
}

func parseMul(mul string) (int, int) {
	idx := strings.IndexRune(mul, ',')
	first, _ := strconv.Atoi(mul[4:idx])
	second, _ := strconv.Atoi(mul[idx+1 : len(mul)-1])
	return first, second
}
