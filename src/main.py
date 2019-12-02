from utils import fetch_input
from days import day_1
from days import day_2

if not __name__ == "__main__":
    exit('Not designed to run as module')

print('Day 1')
print('Solution A:', day_1.solution_a.sol(fetch_input.get_file(1)))
print('Solution B:', day_1.solution_b.sol(fetch_input.get_file(1)), '\n')

print('Day 2')
print('Solution A:', day_2.solution_a.sol(fetch_input.get_file(2)))
print('Solution B:', day_2.solution_b.sol(fetch_input.get_file(2)), '\n')
