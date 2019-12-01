from .utils_1 import *


def sol(f):
    sum = 0
    for num in f.readlines():
        temp = get_fuel(num)
        while temp >= 0:
            sum += temp
            temp = get_fuel(temp)
    f.close()
    return int(sum)
