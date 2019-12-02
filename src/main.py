from utils import solution_runner

if not __name__ == "__main__":
    exit('Not designed to run as module')

done_solutions = 2

for i in range(1, done_solutions + 1):
    print('Day {}'.format(i))
    print('Solution A:', solution_runner.run(i, 'a'))
    print('Solution B:', solution_runner.run(i, 'b'), '\n')
