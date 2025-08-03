# Dedicated to my Shree DR.MDD

ADJACENT = [complex(a, b) for a in (-1, 0, 1) for b in (-1, 0, 1) if a or b]

def annotate(garden: list[str]) -> list[str]:
    h = len(garden)
    w = len(garden[0]) if garden else 0

    if not all(len(r) == w for r in garden):
        raise ValueError("The board is invalid with current input.")

    blossom = set()
    for j, stripe in enumerate(garden):
        for i, ch in enumerate(stripe):
            if ch == "*":
                blossom.add(complex(i, j))
            elif ch != " ":
                raise ValueError("The board is invalid with current input.")

    def bloom(p: complex) -> str:
        if p in blossom:
            return "*"
        cnt = sum((p + d) in blossom for d in ADJACENT)
        return str(cnt) if cnt else " "

    return [
        "".join(bloom(complex(i, j)) for i in range(w))
        for j in range(h)
    ]
