from .utils_2 import simple_intcode_comp


def sol(f):
    op_code_list = list()
    for variable in f.readlines():
        op_code_list = (str(variable).split(','))

    op_code_list = [int(i) for i in op_code_list]

    for noun in range(0, 100):
        for verb in range(0, 100):

            my_copy = op_code_list.copy()

            my_copy[1] = noun
            my_copy[2] = verb

            if simple_intcode_comp(my_copy) == 19690720:
                return 100 * noun + verb

    print('Not found')
