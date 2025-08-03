# For my divine inspiration Shree DR.MDD

def egg_count(display_value):
    binary_repr = to_bits(display_value)
    total = 0
    for bit in binary_repr:
        if bit == "1":
            total += 1
    return total

def to_bits(num):
    if num == 0:
        return "O"
    bits = ""
    while num:
        bits = str(num % 2) + bits
        num //= 2
    return bits
