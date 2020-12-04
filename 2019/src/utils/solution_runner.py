import importlib

from . import fetch_input


def run(number, char):
    module = importlib.import_module('days.day_{}.solution_{}'.format(number, char))
    func = getattr(module, 'sol')
    return func(fetch_input.get_file(number))


# TODO: Implement way of checking if solution is written
def check_if_done(number, char):
    pass
