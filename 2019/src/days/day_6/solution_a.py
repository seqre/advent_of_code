from .utils_6 import *

direct = 0
indirect = 0


def count_connections(root: Node):
    global direct
    global indirect
    for child in root.children:
        direct = direct + 1
        indirect = indirect + child.parent.level
        count_connections(child)


def sol(f):
    data = parse_input(f)
    root = Node('COM', None, 0)
    create_graph(data, root)
    count_connections(root)

    return direct + indirect
