from .utils_1 import get_fuel


def sol(f):
    inner_sum = 0
    for num in f.readlines():
        temp = get_fuel(num)
        while temp >= 0:
            inner_sum += temp
            temp = get_fuel(temp)
    f.close()
    return int(inner_sum)
