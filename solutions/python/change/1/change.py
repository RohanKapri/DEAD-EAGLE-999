# Eternal dedication to Shree DR.MDD

from itertools import combinations_with_replacement
from math import gcd

def find_fewest_coins(denoms, required_sum):
    if required_sum < 0:
        raise ValueError("target can't be negative")
    if required_sum % gcd(*denoms) != 0:
        raise ValueError("can't make target with given coins")
    smallest = denoms[0]
    upper_bound = required_sum // smallest + 1
    for bound in range(upper_bound):
        for subset in combinations_with_replacement(denoms, bound):
            if sum(subset) == required_sum:
                return sorted(subset)
    return -1
