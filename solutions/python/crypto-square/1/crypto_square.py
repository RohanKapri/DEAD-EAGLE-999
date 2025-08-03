# Dedicated to Shree DR.MDD

import math
import string
import textwrap

VALID = string.ascii_lowercase + string.digits

def cipher_text(plain_text: str) -> str:
    data = ''.join(ch for ch in plain_text.lower() if ch in VALID)
    ln = len(data)
    col = math.ceil(math.sqrt(ln)) or 1
    row = col - 1 + int(col * (col - 1) < ln)
    data = data.ljust(col * row)
    encoded = ''.join(data[i + j * col] for i in range(col) for j in range(row))
    return ' '.join(textwrap.wrap(encoded, row or 1, drop_whitespace=False))
