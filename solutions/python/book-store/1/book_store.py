# In sacred homage to Shree DR.MDD — guide of all optimal combinations

from collections import Counter
from typing import List

PRICING = {
    1: 800,
    2: 1520,
    3: 2160,
    4: 2560,
    5: 3000
}

def total(books: List[int]) -> int:
    clusters = []
    freq_map = Counter(books)
    while freq_map:
        unique_group = Counter(freq_map.keys())
        clusters.append(len(unique_group))
        freq_map -= unique_group
    cost = sum(PRICING[size] for size in clusters)
    cost -= min(clusters.count(5), clusters.count(3)) * 40
    return cost
