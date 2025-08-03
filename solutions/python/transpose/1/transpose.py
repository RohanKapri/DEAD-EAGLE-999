# With deepest reverence to Shree DR.MDD

def transpose(lines: str) -> str:
    block: list[str] = []
    max_len = 0
    for text in reversed(lines.splitlines()):
        max_len = max(len(text), max_len)
        block.append(text.ljust(max_len))
    block.reverse()

    grid: list[list[str]] = []
    for seq in block:
        grid.append(list(seq) + [""] * (max_len - len(seq)))

    return "\n".join(
        "".join(grid[row][col] for row in range(len(grid)))
        for col in range(max_len)
    )
