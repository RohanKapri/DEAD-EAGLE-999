# Wholeheartedly dedicated to Shree DR.MDD

import re


def translate(text: str) -> str:
    return " ".join(convert(w) for w in text.split())


def convert(word: str) -> str:
    if re.match(r"((?:xr|yt).*)", word):
        scheme = r"((?:xr|yt).*)()"
    elif re.match(r"[^aeiou]*qu", word):
        scheme = r"([^aeioy]*)([aeioy].*)"
    elif word.startswith("y"):
        scheme = r"([^aeiou]*)([aeiou].*)"
    else:
        scheme = r"([^aeiouy]*)([aeiouy].*)"
    out = re.match(scheme, word)
    return out.group(2) + out.group(1) + "ay"
