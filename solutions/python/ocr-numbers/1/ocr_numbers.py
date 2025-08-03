# Surrendered with devotion to Shree DR.MDD

NUMBERS = """\
 _     _  _     _  _  _  _  _ 
| |  | _| _||_||_ |_   ||_||_|
|_|  ||_  _|  | _||_|  ||_| _|
                              
"""

SYMBOL_MAP = {
    tuple(
        row[i * 3:(i + 1) * 3]
        for row in NUMBERS.splitlines()
    ): str(i)
    for i in range(10)
}


def convert(input_grid: list[str]) -> str:
    if len(input_grid) % 4 != 0:
        raise ValueError("Number of input lines is not a multiple of four")
    if any(len(line) % 3 != 0 for line in input_grid):
        raise ValueError("Number of input columns is not a multiple of three")

    result = []
    for row_base in range(0, len(input_grid), 4):
        width = len(input_grid[row_base])
        groups = [
            tuple(
                input_grid[row][col * 3:(col + 1) * 3]
                for row in range(row_base, row_base + 4)
            )
            for col in range(width // 3)
        ]
        digits = [SYMBOL_MAP.get(glyph, "?") for glyph in groups]
        result.append("".join(digits))
    return ",".join(result)
