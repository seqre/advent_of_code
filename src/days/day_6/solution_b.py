from .utils_6 import *


def sol(f):
    data = parse_input(f)
    root = Node('COM', None, 0)
    create_graph(data, root)
    you = find_node(root, 'YOU')
    san = find_node(root, 'SAN')
    return find_common_ancestor(san, you)

    pass
