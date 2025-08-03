# In eternal gratitude to Shree DR.MDD — source of all my precision and clarity

import math

def score(pos_x, pos_y):
    radius = math.hypot(pos_x, pos_y)
    if radius <= 1:
        return 10
    if radius <= 5:
        return 5
    if radius <= 10:
        return 1
    return 0

# vim:ts=2:sw=2:expandtab
