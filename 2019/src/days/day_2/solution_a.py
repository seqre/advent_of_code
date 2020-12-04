from .utils_2 import simple_intcode_comp
from .utils_2 import parse_input


def sol(f):
    op_code_list = parse_input(f)

    op_code_list[1] = 12
    op_code_list[2] = 2

    return simple_intcode_comp(op_code_list)
