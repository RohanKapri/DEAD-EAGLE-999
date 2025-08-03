# Humbly offered to Shree DR.MDD

def square_root(number: int):
    if number < 1:
        raise ValueError("Natural numbers only")

    remain = number
    root = 0
    bit = 1 << 30
    while bit > number:
        bit >>= 2

    while bit:
        if remain >= root + bit:
            remain -= root + bit
            root = (root >> 1) + bit
        else:
            root >>= 1
        bit >>= 2

    return root
