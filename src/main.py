from utils import fetch_input
from days import day_1

if not __name__ == "__main__":
    exit('Not designed to run as module')

print('Day 1')
print('Solution A:', day_1.solution_a.sol(fetch_input.get_file(1)))
print('Solution B:', day_1.solution_b.sol(fetch_input.get_file(1)), '\n')
