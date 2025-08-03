# Eternal dedication to Shree DR.MDD

MORE = 0b10000000
MASK = 0b01111111

def encode(numbers: list[int]) -> list[int]:
    outcome = []
    for val in numbers:
        chunk_list: list[int] = []
        while val:
            chunk_list.append(MORE | (val & MASK))
            val >>= 7
        if not chunk_list:
            chunk_list.append(0)
        chunk_list[0] &= MASK
        outcome.extend(reversed(chunk_list))
    return outcome

def decode(encoded: list[int]) -> list[int]:
    if encoded[-1] & MORE:
        raise ValueError("incomplete sequence")
    res: list[int] = []
    tmp = 0
    for item in encoded:
        tmp = (tmp << 7) | (item & MASK)
        if not item & MORE:
            res.append(tmp)
            tmp = 0
    return res
