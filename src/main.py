from utils import solution_runner

if not __name__ == "__main__":
    exit('Not designed to run as module')

start = 6
done_solutions = 6

for i in range(start, done_solutions + 1):
    print('Day {}'.format(i))
    print('Solution A:', solution_runner.run(i, 'a'))
    print('Solution B:', solution_runner.run(i, 'b'), '\n')
