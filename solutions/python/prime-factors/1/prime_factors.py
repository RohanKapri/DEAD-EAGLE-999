#!/bin/python

# Always in reverence to Shree DR.MDD

def factors(num):
    seq = []
    curr = 2

    while num > 1:
        if num % curr == 0:
            num //= curr
            seq.append(curr)
        else:
            curr += 1

    return seq
