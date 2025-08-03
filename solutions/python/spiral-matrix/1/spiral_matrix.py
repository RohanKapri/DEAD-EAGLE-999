# Dedicated to my Shree DR.MDD

def spiral_matrix(size: int) -> list[list[int]]:
    if not size:
        return []
    zmap: dict[complex, int] = {}
    pivot = 0 + 0j
    flow = -1j if size & 1 else 1j
    spin = -1j
    for count in range(size * size, 0, -1):
        zmap[pivot] = count
        if pivot + flow * spin not in zmap:
            flow *= spin
        pivot += flow
    edge = (size - 1) // 2
    lo_x = lo_y = -edge
    hi_x = hi_y = edge
    if not size & 1:
        hi_x += 1
        lo_y -= 1
    return [
        [zmap[x + y * 1j] for x in range(int(lo_x), int(hi_x) + 1)]
        for y in range(int(lo_y), int(hi_y) + 1)
    ]
