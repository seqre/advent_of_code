from .utils_2 import simple_intcode_comp


def sol(f):
    op_code_list = list()
    for variable in f.readlines():
        op_code_list = (str(variable).split(','))

    op_code_list = [int(i) for i in op_code_list]

    op_code_list[1] = 12
    op_code_list[2] = 2

    return simple_intcode_comp(op_code_list)
