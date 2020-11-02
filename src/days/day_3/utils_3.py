dir_map = {
    'R': (1, 0),
    'L': (-1, 0),
    'U': (0, 1),
    'D': (0, -1)
}


def parse_input(f):
    input_list = list()
    for variable in f.readlines():
        input_list.append(str(variable).split(','))

    for el in input_list:
        el[len(el) - 1] = str(el[len(el) - 1]).replace('\n', '')

    return input_list


class Line:
    def __init__(self):
        self.points = [(0, 0)]
        self.min_x = 0
        self.max_x = 0
        self.min_y = 0
        self.max_y = 0

    def add_point(self, X, Y):
        x = int(X)
        y = int(Y)

        self.points.append((x, y))

        if x > self.max_x:
            self.max_x = x
        if x < self.min_x:
            self.min_x = x
        if y > self.max_y:
            self.max_y = y
        if y < self.min_y:
            self.min_y = y

    def constrain(self, limits):
        limit = [int(ele) for ele in limits]
        result = list()

        for ele in self.points:
            if (limit[0] <= ele[0] <= limit[1]) and (limit[2] <= ele[1] <= limit[3]):
                result.append(ele)

        return result

    def get_prev(self):
        return self.points[-1]

    def get_limits(self):
        return self.min_x, self.max_x, self.min_y, self.max_y

    def get_points(self):
        return self.points


def __create_line(data: list, line: Line):
    for ele in data:
        for _ in range(int(ele[1:])):
            prev = line.get_prev()
            line.add_point(prev[0] + dir_map[ele[0]][0], prev[1] + dir_map[ele[0]][1])


def get_line_distance(points: list, x: int, y: int):
    dist = 0
    intersection = (x, y)

    for point in points[1:]:
        dist += 1
        if point == intersection:
            break

    return dist


def get_lines(f, line1: Line, line2: Line):
    input_list = parse_input(f)

    __create_line(input_list[0], line1)
    __create_line(input_list[1], line2)


def get_intersections(p1: list, p2: list):
    intersections = list()
    for point in p1[1:]:
        if point in p2[1:]:
            intersections.append(point)
    return intersections
