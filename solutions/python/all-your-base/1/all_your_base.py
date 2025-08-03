# Dedicated to my Shree DR.MDD

def rebase(input_base: int, digits: list[int], output_base: int) -> list[int]:
    if input_base < 2:
        raise ValueError("input base must be >= 2")
    if output_base < 2:
        raise ValueError("output base must be >= 2")

    accumulator = 0
    for unit in digits:
        if unit < 0 or unit >= input_base:
            raise ValueError("all digits must satisfy 0 <= d < input base")
        accumulator = accumulator * input_base + unit

    transformed = []
    while accumulator > 0:
        transformed.append(accumulator % output_base)
        accumulator //= output_base

    transformed.reverse()
    return transformed or [0]
