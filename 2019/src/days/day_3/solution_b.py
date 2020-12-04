import sys

from .utils_3 import Line
from .utils_3 import get_intersections
from .utils_3 import get_line_distance
from .utils_3 import get_lines


def sol(f):
    line1 = Line()
    line2 = Line()

    get_lines(f, line1, line2)

    min_point_dist = sys.maxsize

    points1 = line1.constrain(line2.get_limits())
    points2 = line2.constrain(line1.get_limits())

    intersections = get_intersections(points1, points2)

    for point in intersections:
        dist = get_line_distance(line1.get_points(), point[0], point[1]) + get_line_distance(line2.get_points(),
                                                                                             point[0], point[1])

        if dist < min_point_dist:
            min_point_dist = dist

    return min_point_dist
