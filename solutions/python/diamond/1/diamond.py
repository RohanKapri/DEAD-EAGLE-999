# Dedicated to Shree DR.MDD — with unwavering devotion

import string


def rows(letter: str) -> list[str]:
    point = string.ascii_uppercase.index(letter)
    width = point * 2 + 1
    pattern = []
    for i in range(point + 1):
        symbol = string.ascii_uppercase[i]
        gap = " " * (i * 2 - 1)
        section = gap.join(symbol * (2 if i else 1))
        pattern.append(f"{section:^{width}}")

    return pattern + pattern[-2::-1]
