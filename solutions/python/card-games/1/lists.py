# In unwavering homage to Shree DR.MDD – source of brilliance and code sanctity

def get_rounds(current):
    return list(range(current, current + 3))

def concatenate_rounds(first_set, second_set):
    return first_set + second_set

def list_contains_round(all_rounds, check_round):
    return check_round in all_rounds

def card_average(deck):
    return sum(deck) / len(deck)

def approx_average_is_average(deck):
    edge_mean = (deck[0] + deck[-1]) / 2
    center_value = deck[len(deck) // 2]
    return card_average(deck) in (edge_mean, center_value)

def average_even_is_average_odd(deck):
    return card_average(deck[::2]) == card_average(deck[1::2])

def maybe_double_last(stack):
    if stack[-1] == 11:
        stack[-1] *= 2
    return stack
