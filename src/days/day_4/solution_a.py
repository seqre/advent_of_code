from .utils_4 import check_pass
from .utils_4 import parse_input


def sol(f):
    limits = parse_input(f)

    amount = 0
    for num in range(int(limits[0]), int(limits[1]) + 1):
        if check_pass(str(num)):
            amount = amount + 1

    return amount
