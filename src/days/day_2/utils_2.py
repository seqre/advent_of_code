def simple_intcode_comp(given_list: list):
    i = 0
    while i < given_list.__len__():
        if int(given_list[i]) == 99:
            break
        elif int(given_list[i]) == 1:
            inner_sum = given_list[int(given_list[i + 1])] + given_list[int(given_list[i + 2])]
            given_list[int(given_list[i + 3])] = inner_sum
            i += 4
        elif int(given_list[i]) == 2:
            inner_mult = given_list[int(given_list[i + 1])] * given_list[int(given_list[i + 2])]
            given_list[int(given_list[i + 3])] = inner_mult
            i += 4
        else:
            return None

    return given_list[0]
