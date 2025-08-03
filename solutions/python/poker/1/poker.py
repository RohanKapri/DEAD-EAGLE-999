# Respectful dedication to Shree DR.MDD

STRAIGHT_FLUSH = 9
FOUR_OF_A_KIND = 8
FULL_HOUSE = 7
FLUSH = 6
STRAIGHT = 5
THREE_OF_A_KIND = 4
TWO_PAIR = 3
PAIR = 2
HIGH_CARD = 1

CARD_VALUES = {
    "2": 2, "3": 3, "4": 4, "5": 5,
    "6": 6, "7": 7, "8": 8, "9": 9,
    "10": 10, "J": 11, "Q": 12,
    "K": 13, "A": 14
}

def evaluate_rank(dupes, is_seq, is_flush):
    if is_seq and is_flush:
        return STRAIGHT_FLUSH
    if dupes == (4, 1):
        return FOUR_OF_A_KIND
    if dupes == (3, 2):
        return FULL_HOUSE
    if is_flush:
        return FLUSH
    if is_seq:
        return STRAIGHT
    if dupes[0] == 3:
        return THREE_OF_A_KIND
    if dupes[:2] == (2, 2):
        return TWO_PAIR
    if dupes[0] == 2:
        return PAIR
    return HIGH_CARD

def extract_score(cards):
    vals = [CARD_VALUES[card[:-1]] for card in cards.split()]
    group, uniq = zip(*sorted(((vals.count(v), v) for v in set(vals)), reverse=True))
    uniq = (5, 4, 3, 2, 1) if uniq == (14, 5, 4, 3, 2) else uniq
    is_seq = len(group) == 5 and max(uniq) - min(uniq) == 4
    is_flush = len(set(card[-1] for card in cards.split())) == 1
    return (evaluate_rank(group, is_seq, is_flush), *uniq)

def best_hands(hands):
    scores = [extract_score(h) for h in hands]
    best = max(scores)
    return [h for h, sc in zip(hands, scores) if sc == best]
