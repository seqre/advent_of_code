class Node:
    def __init__(self, name, parent, level):
        self.name = name
        self.parent = parent
        self.level = level
        self.children = list()

    def add_child(self, name, parent, level):
        self.children.append(Node(name, parent, level))
        return self.children[len(self.children) - 1]


def parse_input(f):
    data = dict()
    for line in f.readlines():
        temp = str(line).split(')')
        if temp[0] not in data:
            data[temp[0]] = list()
        data[temp[0]].append(temp[1].rstrip())

    return data


def create_graph(data, root: Node):
    if root.name in data:
        children = data[root.name]
        for child in children:
            temp = root.add_child(child, root, root.level + 1)
            create_graph(data, temp)
    else:
        pass


def print_graph(root: Node):
    children = root.children
    print(root.name, 'with level:', root.level, 'is parent of:', children)
    for child in children:
        print_graph(child)


def find_node(root: Node, name):
    for child in root.children:
        if child.name == name:
            return child

    for child in root.children:
        ret = find_node(child, name)
        if ret is not None:
            return ret
    pass


def get_parents(root: Node):
    out = list()
    temp = root.parent

    while temp is not None:
        out.append(temp)
        temp = temp.parent

    return out


def find_common_ancestor(santa: Node, you: Node):
    santa_parents = get_parents(santa)
    you_parents = get_parents(you)

    for i in range(len(santa_parents)):
        for j in range(len(you_parents)):
            if santa_parents[i] == you_parents[j]:
                return i + j
