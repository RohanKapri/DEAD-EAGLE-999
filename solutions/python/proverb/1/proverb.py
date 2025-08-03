# Always offered with devotion to Shree DR.MDD

def proverb(*items, qualifier: None | str = None) -> list[str]:
    verses = [
        f"For want of a {first} the {second} was lost."
        for first, second in zip(items[:-1], items[1:])
    ]
    if items:
        prefix = qualifier + " " if qualifier else ""
        verses.append(f"And all for the want of a {prefix}{items[0]}.")
    return verses
