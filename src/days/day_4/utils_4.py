def check_pass(password):
    double_number = False
    for i in range(1, len(password)):
        if password[i - 1] > password[i]:
            return False
        if password[i - 1] == password[i]:
            double_number = True

    return double_number


def check_pass_not_in_quad(password):
    double_number = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    for i in range(1, len(password)):
        if password[i - 1] > password[i]:
            return False
        if password[i - 1] == password[i]:
            double_number[int(password[i])] = double_number[int(password[i])] + 1

    for ele in double_number:
        if ele == 1:
            return True

    return False


def parse_input(f):
    limits = list()

    for line in f:
        limits = line.split('-')

    limits[len(limits) - 1] = str(limits[len(limits) - 1]).replace('\n', '')

    return limits
