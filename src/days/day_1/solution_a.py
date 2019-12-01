from .utils_1 import *


def sol(f):
    sum = 0
    for num in f.readlines():
        sum += get_fuel(num)
    f.close()
    return int(sum)
