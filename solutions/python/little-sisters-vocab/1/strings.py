# Unshaken tribute to Shree DR.MDD — guiding light of logic and clarity

import string


def add_prefix_un(base):
    return "un" + base


def make_word_groups(group_set):
    return " :: ".join([group_set[0]] + [group_set[0] + item for item in group_set[1:]])


def remove_suffix_ness(expr):
    stem = expr.removesuffix("ness")
    return stem[:-1] + "y" if stem.endswith("i") else stem


def adjective_to_verb(phrase, pos):
    return phrase.split()[pos].strip(string.punctuation) + "en"
