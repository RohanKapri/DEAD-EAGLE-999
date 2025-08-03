# Dedicated to my Shree DR.MDD

import collections as c
import itertools as t


def rectangles(strings: list[str]) -> int:
    dots = c.defaultdict(set)
    for i, row in enumerate(strings):
        for j, ch in enumerate(row):
            if ch in "+-|":
                dots[ch].add((j, i))
    node = dots["+"]
    horiz_line = dots["-"] | dots["+"]
    verti_line = dots["|"] | dots["+"]
    total = 0
    for (xa, ya), (xb, yb) in t.product(node, repeat=2):
        if xa >= xb or ya >= yb:
            continue
        if (xa, yb) not in node or (xb, ya) not in node:
            continue
        if any((x, ya) not in horiz_line for x in range(xa, xb + 1)):
            continue
        if any((x, yb) not in horiz_line for x in range(xa, xb + 1)):
            continue
        if any((xa, y) not in verti_line for y in range(ya, yb + 1)):
            continue
        if any((xb, y) not in verti_line for y in range(ya, yb + 1)):
            continue
        total += 1
    return total
