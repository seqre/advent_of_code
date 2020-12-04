import sys

from .utils_3 import Line
from .utils_3 import get_lines


def sol(f):
    line1 = Line()
    line2 = Line()

    get_lines(f, line1, line2)

    min_point_dist = sys.maxsize

    points1 = line1.constrain(line2.get_limits())
    points2 = line2.constrain(line1.get_limits())

    for point in points1[1:]:
        if point in points2[1:]:
            temp_dist = abs(point[0]) + abs(point[1])

            if temp_dist < min_point_dist:
                min_point_dist = temp_dist

    return min_point_dist
