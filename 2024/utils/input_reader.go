package utils

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strings"
)

func ReadGrid[T GridType[T]](path string, transform func(rune) T) Grid[T] {
	lines := ReadLines(path)
	maxX, maxY := len(lines[0]), len(lines)
	grid := InitGrid[T](maxX, maxY)

	for y, line := range lines {
		for x, char := range line {
			grid[x][y] = transform(char)
		}
	}

	result := Grid[T]{Grid: grid, MaxX: maxX, MaxY: maxY}
	return result
}

func ReadLinesOfWords(path string) [][]string {
	lines := ReadLines(path)

	linesOfWords := make([][]string, len(lines))
	for i, line := range lines {
		linesOfWords[i] = strings.Split(line, " ")
	}

	return linesOfWords
}

func ReadLines(path string) []string {
	scanner, file := getScanner(path)
	defer file.Close()

	scanner.Split(bufio.ScanLines)
	var lines []string
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	return lines
}

func ReadRunes(path string) []rune {
	scanner, file := getScanner(path)
	defer file.Close()

	scanner.Split(bufio.ScanRunes)
	var runes []rune
	for scanner.Scan() {
		bytes := scanner.Bytes()
		for _, run := range bytes {
			runes = append(runes, rune(run))
		}

	}

	return runes
}

func ReadAsString(path string) string {
	bytes := getBytes(path)
	return string(bytes)
}

func ReadWords(path string) []string {
	scanner, file := getScanner(path)
	defer file.Close()

	scanner.Split(bufio.ScanWords)
	var words []string
	for scanner.Scan() {
		words = append(words, scanner.Text())
	}

	return words
}

func getBytes(path string) []byte {
	b, err := os.ReadFile(path)
	if err != nil {
		panic(err)
	}
	return b

}

func getScanner(path string) (*bufio.Scanner, *os.File) {
	file, err := os.Open(path)
	if err != nil {
		panic(err)
	}
	scanner := bufio.NewScanner(file)
	return scanner, file
}

func GetPath(day int, sample bool) string {
	suffix := ""
	if sample {
		suffix = "-sample"
	}

	path := fmt.Sprintf("./input/%d%s.txt", day, suffix)

	if _, err := os.Stat(path); errors.Is(err, os.ErrNotExist) {
		panic(fmt.Sprintf("path does not exist: %s", path))
	}

	return path
}
