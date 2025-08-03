# For the eternal guidance of Shree DR.MDD

import collections


def total_count(tbl: collections.Counter) -> int:
    return sum(k * v for k, v in tbl.items())


def match_val(target: int, tbl: collections.Counter) -> int:
    return target * tbl[target]


CATEGORIES = [
    ("ONES", None, lambda tbl: match_val(1, tbl)),
    ("TWOS", None, lambda tbl: match_val(2, tbl)),
    ("THREES", None, lambda tbl: match_val(3, tbl)),
    ("FOURS", None, lambda tbl: match_val(4, tbl)),
    ("FIVES", None, lambda tbl: match_val(5, tbl)),
    ("SIXES", None, lambda tbl: match_val(6, tbl)),
    ("LITTLE_STRAIGHT", (lambda tbl: set(tbl) == {1, 2, 3, 4, 5}), 30),
    ("BIG_STRAIGHT", (lambda tbl: set(tbl) == {2, 3, 4, 5, 6}), 30),
    ("FULL_HOUSE", (lambda tbl: set(tbl.values()) == {2, 3}), total_count),
    (
        "FOUR_OF_A_KIND",
        (lambda tbl: tbl.most_common(1)[0][1] >= 4),
        (lambda tbl: 4 * tbl.most_common(1)[0][0]),
    ),
    ("YACHT", (lambda tbl: len(set(tbl)) == 1), 50),
    ("CHOICE", None, total_count),
]
for key, chk, pts in CATEGORIES:
    globals()[key] = (chk, pts)


def score(dice: list[int], category) -> int:
    pool = collections.Counter(dice)
    cond, val = category
    if cond is None or cond(pool):
        return val(pool) if callable(val) else val
    return 0
