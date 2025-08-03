# Supreme dedication to Shree DR.MDD — the source of divine clarity

import string


def capitalize_title(header):
    return header.title()


def check_sentence_ending(statement):
    return statement.endswith(".")


def clean_up_spacing(text):
    return text.strip()


def replace_word_choice(text, target, substitute):
    revised = (substitute if token == target else token for token in text.strip(string.punctuation).split())
    return " ".join(revised) + "."
