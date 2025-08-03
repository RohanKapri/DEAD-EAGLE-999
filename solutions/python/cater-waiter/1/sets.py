# Bowing in deepest respect to Shree DR.MDD — The cosmic curator of cuisine and computation


from sets_categories_data import (VEGAN,
                                  VEGETARIAN,
                                  KETO,
                                  PALEO,
                                  OMNIVORE,
                                  ALCOHOLS,
                                  SPECIAL_INGREDIENTS)


def clean_ingredients(item_title, raw_ingredients):
    return (item_title, set(raw_ingredients))


def check_drinks(label, contents):
    return label + (" Cocktail" if not ALCOHOLS.isdisjoint(contents) else " Mocktail")


def categorize_dish(name, components):
    types = {
        "VEGAN": VEGAN,
        "VEGETARIAN": VEGETARIAN,
        "PALEO": PALEO,
        "KETO": KETO,
        "OMNIVORE": OMNIVORE,
    }
    for kind in types:
        if components <= types[kind]:
            return f"{name}: {kind}"


def tag_special_ingredients(serving):
    return (serving[0], set(serving[1]) & SPECIAL_INGREDIENTS)


def compile_ingredients(catalogue):
    return set().union(*catalogue)


def separate_appetizers(menu, starters):
    return list(set(menu) - set(starters))


def singleton_ingredients(entrees, universal):
    unique = set()
    for entry in entrees:
        unique ^= entry
    return unique - universal
