package days

import (
	"aoc_2024/utils"
	"github.com/dominikbraun/graph"
	"strconv"
	"strings"
)
import set "github.com/hashicorp/go-set"

type Day05 struct {
	adjacency map[int]*set.Set[int]
	reports   [][]int
}

func NewDay05(path string) Solution {
	lines := utils.ReadLines(path)

	var rules, reports []string
	rulesIncoming := true

	for _, line := range lines {
		if line == "" {
			rulesIncoming = false
			continue
		}

		if rulesIncoming {
			rules = append(rules, line)
		} else {
			reports = append(reports, line)
		}
	}

	adjacency := make(map[int]*set.Set[int])
	for _, rule := range rules {
		split := strings.Split(rule, "|")
		from, _ := strconv.Atoi(split[0])
		to, _ := strconv.Atoi(split[1])

		_, ok := adjacency[from]
		if !ok {
			adjacency[from] = set.New[int](1)
		}
		adj, _ := adjacency[from]
		adj.Insert(to)
	}

	finalReports := make([][]int, len(reports))
	for i, line := range reports {
		report := strings.Split(line, ",")
		reportInt := make([]int, len(report))
		for j, s := range report {
			reportInt[j], _ = strconv.Atoi(s)
		}
		finalReports[i] = reportInt
	}

	return &Day05{adjacency: adjacency, reports: finalReports}
}

func (d *Day05) Part1() string {
	var validMiddleNumbers int

	for _, report := range d.reports {
		if d.check(report) {
			mid := len(report) / 2
			validMiddleNumbers += report[mid]
		}
	}

	return strconv.Itoa(validMiddleNumbers)
}

func (d *Day05) check(report []int) bool {
	for i := 0; i < len(report); i++ {
		for j := i + 1; j < len(report); j++ {
			adj, ok := d.adjacency[report[j]]
			mustBeEarlier := false
			if ok {
				mustBeEarlier = adj.Contains(report[i])
			}

			if mustBeEarlier {
				return false
			}
		}
	}
	return true
}

func (d *Day05) Part2() string {

	var validMiddleNumbers int

	for _, report := range d.reports {
		if !d.check(report) {
			report = d.reorder(report)
			mid := len(report) / 2
			validMiddleNumbers += report[mid]
		}
	}

	return strconv.Itoa(validMiddleNumbers)
}

func (d *Day05) reorder(report []int) []int {
	g := graph.New(graph.IntHash, graph.Directed())

	for _, num := range report {
		_ = g.AddVertex(num)
	}

	for _, num := range report {
		adj, ok := d.adjacency[num]
		if ok {
			for _, to := range adj.Slice() {
				_ = g.AddEdge(to, num)
			}
		}
	}

	ret, _ := graph.TopologicalSort(g)

	return ret

}
