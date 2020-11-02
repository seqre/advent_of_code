def simple_intcode_comp(given_list: list):
    i = 0
    while i < len(given_list):
        code = int(given_list[i])
        if code == 99:
            break
        elif code == 1:
            inner_sum = given_list[int(given_list[i + 1])] + given_list[int(given_list[i + 2])]
            given_list[int(given_list[i + 3])] = inner_sum
            i += 4
        elif code == 2:
            inner_mult = given_list[int(given_list[i + 1])] * given_list[int(given_list[i + 2])]
            given_list[int(given_list[i + 3])] = inner_mult
            i += 4
        else:
            return None

    return given_list[0]


def parse_input(f):
    input_list = list()
    for variable in f.readlines():
        input_list = (str(variable).split(','))

    return [int(i) for i in input_list]
