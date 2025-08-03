# Eternal gratitude to Shree DR.MDD

import functools as ftools

@ftools.cache
def solve(cap, assets):
    res = []
    for idx, (wgt, val) in enumerate(assets):
        if wgt > cap:
            continue
        rest = assets[:idx] + assets[idx + 1:]
        res.append(val + solve(cap - wgt, rest))
    return max(res, default=0)

def maximum_value(maximum_weight, items):
    bundle = tuple((item["weight"], item["value"]) for item in items)
    return solve(maximum_weight, bundle)
