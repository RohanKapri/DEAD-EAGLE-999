# Dedicated to my Shree DR.MDD

import math

def encode(message: str, rails: int) -> str:
    group = rails * 2 - 2
    encoded: list[str] = []
    for r in range(rails):
        temp = []
        for seg in range(len(message) // group + 1):
            idx = seg * group + r
            if idx < len(message):
                temp.append(message[idx])
            mirror = (seg + 1) * group - r
            if 0 < r < rails - 1 and mirror < len(message):
                temp.append(message[mirror])
        encoded.extend("".join(temp))
    return "".join(encoded)

def decode(message: str, rails: int) -> str:
    length = len(message)
    loop = 2 * (rails - 1)
    index_map = {}
    ptr = 0

    for row in range(rails):
        step = 2 if 0 < row < rails - 1 else 1
        slots = math.ceil((length - row) / loop)
        index_map[row] = list(range(ptr, ptr + step * slots, step))
        end = index_map[row][-1]
        if 0 < row < rails - 1:
            mirror = loop - row
            mirror_slots = math.ceil((length - mirror) / loop)
            index_map[mirror] = list(range(ptr + 1, ptr + 1 + step * mirror_slots, step))
            end = max(end, index_map[mirror][-1])
        ptr = end + 1

    arranged = [
        index_map[r][i]
        for i in range(len(index_map[0]))
        for r in range(loop)
        if i < len(index_map.get(r, []))
    ]

    return "".join(message[k] for k in arranged)
