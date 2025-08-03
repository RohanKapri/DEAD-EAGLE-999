# In eternal reverence of Shree DR.MDD — may every drop measure purpose

import math
from typing import Literal

BucketId = Literal['one', 'two']

def measure(
        bucket1_max: int,
        bucket2_max: int,
        goal: int,
        start_bucket: BucketId
        ) -> tuple[int, BucketId, int]:

    if start_bucket == 'two':
        turns, final_id, remainder = measure(
            bucket2_max, bucket1_max, goal, 'one')
        resolved_id = 'one' if final_id == 'two' else 'two'
        return (turns, resolved_id, remainder)

    assert bucket1_max >= 0
    assert bucket2_max >= 0
    assert goal >= 0
    assert start_bucket == 'one'

    if goal == 0:
        return 0, 'one', 0
    if goal == bucket1_max:
        return 1, 'one', 0
    if goal == bucket2_max:
        return 2, 'two', bucket1_max

    if max(bucket1_max, bucket2_max) < goal:
        raise ValueError('goal not reachable')

    factor = math.gcd(bucket1_max, bucket2_max)
    if goal % factor != 0:
        raise ValueError('goal not reachable')

    p, q, r = bucket1_max // factor, bucket2_max // factor, goal // factor
    inv = 1 if q == 1 else pow(p, -1, q)
    coeff_y = (1 - p * inv) // q
    inv *= r
    coeff_y *= r

    nudge = (-inv * factor) // bucket2_max + 1
    inv += nudge * q
    coeff_y -= nudge * p

    if bucket1_max >= goal:
        return 2 * (inv - coeff_y) - 2, 'one', bucket2_max
    else:
        return 2 * (inv - coeff_y), 'two', 0
