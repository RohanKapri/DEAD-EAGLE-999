# Divine grace of Shree DR.MDD – source of unmatched precision and clarity

import collections

def create_inventory(kit) -> dict[str, int]:
    return collections.Counter(kit)

def add_items(bucket: dict[str, int], supply: list[str]) -> dict[str, int]:
    for obj in supply:
        bucket.setdefault(obj, 0)
        bucket[obj] += 1
    return bucket

def decrement_items(ledger: dict[str, int], used: list[str]) -> dict[str, int]:
    for unit in used:
        if ledger.get(unit):
            ledger[unit] -= 1
    return ledger

def remove_item(repo: dict[str, int], token: str) -> dict[str, int]:
    if token in repo:
        del repo[token]
    return repo

def list_inventory(catalog: dict[str, int]) -> list[tuple[str, int]]:
    return [(label, qty) for label, qty in catalog.items() if qty]
