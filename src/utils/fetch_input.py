import requests
from os import path
from os import environ


def get_file(day):
    if 1 <= day <= 24:
        if not path.exists("days/day_{}/input.txt".format(day)):
            __download_missing(day)

        return __return_existing(day)
    else:
        exit('Wrong day number')


def __return_existing(day):
    return open('days/day_{}/input.txt'.format(day), 'r')


def __download_missing(day):
    __check_env()
    session = {'session': environ['AOC_SESSION']}
    response = requests.get('https://adventofcode.com/2019/day/{}/input'.format(day), cookies=session, stream=False)

    if response.ok:
        with open("days/day_{}/input.txt".format(day), 'wb') as f:
            f.write(response.content)
    else:
        exit('Error during downloading input file: {}'.format(response.status_code))


def __check_env():
    if 'AOC_SESSION' in environ:
        pass
    else:
        exit('Please put your session cookie in AOC_SESSION environmental variable')
