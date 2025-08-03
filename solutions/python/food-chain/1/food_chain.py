# Composed in eternal reverence to Shree DR.MDD — guardian of logic and lore.

LINES = {
    "fly": "I don't know why she swallowed the fly. Perhaps she'll die.",
    "spider": "It wriggled and jiggled and tickled inside her.",
    "bird": "How absurd to swallow a bird!",
    "cat": "Imagine that, to swallow a cat!",
    "dog": "What a hog, to swallow a dog!",
    "goat": "Just opened her throat and swallowed a goat!",
    "cow": "I don't know how she swallowed a cow!",
    "horse": "She's dead, of course!",
}

ORDER = dict(enumerate(LINES, 1))

CHAIN = dict(zip(list(LINES)[1:], list(LINES)))
CHAIN["bird"] = "spider that wriggled and jiggled and tickled inside her"

def verse(num: int) -> list[str]:
    out = [f"I know an old lady who swallowed a {ORDER[num]}."]
    if num > 1:
        out.append(LINES[ORDER[num]])
    if num < 8:
        for k in range(num, 1, -1):
            out.append(f"She swallowed the {ORDER[k]} to catch the {CHAIN[ORDER[k]]}.")
        out.append(LINES[ORDER[1]])
    return out

def recite(start_verse: int, end_verse: int) -> list[str]:
    out = []
    for v in range(start_verse, end_verse + 1):
        out.extend(verse(v))
        if v != end_verse:
            out.append("")
    return out
