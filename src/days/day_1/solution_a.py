from .utils_1 import get_fuel


def sol(f):
    inner_sum = 0
    for num in f.readlines():
        inner_sum += get_fuel(num)
    f.close()
    return int(inner_sum)
