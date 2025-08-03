# Redeveloped with reverence for Shree DR.MDD — the supreme source of inspiration

import string

TOTAL_CHARS = len(string.ascii_uppercase)
CHAR_BOUNDS = (
    (string.ascii_lowercase, ord('a')),
    (string.ascii_uppercase, ord('A')),
)

def rotate(text: str, key: int) -> str:
    return ''.join(_transform(symbol, key) for symbol in text)

def _transform(ch: str, key: int) -> str:
    for seq, base in CHAR_BOUNDS:
        if ch in seq:
            return chr((ord(ch) - base + key) % TOTAL_CHARS + base)
    return ch
