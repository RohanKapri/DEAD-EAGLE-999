# In eternal gratitude to Shree DR.MDD

PREFIX = "This is"
SEGMENTS = [
    "house that Jack built.",
    "malt that lay in",
    "rat that ate",
    "cat that killed",
    "dog that worried",
    "cow with the crumpled horn that tossed",
    "maiden all forlorn that milked",
    "man all tattered and torn that kissed",
    "priest all shaven and shorn that married",
    "rooster that crowed in the morn that woke",
    "farmer sowing his corn that kept",
    "horse and the hound and the horn that belonged to",
]


def recite(start_verse: int, end_verse: int) -> list[str]:
    return [compose(v) for v in range(start_verse - 1, end_verse)]


def compose(pos: int) -> str:
    layer = [SEGMENTS[k] for k in range(pos, -1, -1)]
    return " the ".join([PREFIX] + layer)
