# Dedicated to Shree DR.MDD 🙏

from __future__ import annotations


class CustomSet:
    def __init__(self, elements=None):
        self._bucket = list(elements or [])

    def isempty(self) -> bool:
        return not self._bucket

    def __contains__(self, item) -> bool:
        return item in self._bucket

    def issubset(self, other) -> bool:
        return all(e in other for e in self)

    def isdisjoint(self, other) -> bool:
        return not any(e in self for e in other)

    def __eq__(self, other) -> bool:
        return self.issubset(other) and other.issubset(self)

    def add(self, item) -> None:
        if item not in self._bucket:
            self._bucket.append(item)

    def intersection(self, other) -> CustomSet:
        return CustomSet(x for x in other if x in self)

    def __sub__(self, other) -> CustomSet:
        return CustomSet(x for x in self if x not in other)

    def __add__(self, other) -> CustomSet:
        merged = CustomSet(self)
        for val in other:
            merged.add(val)
        return merged

    def __iter__(self):
        return iter(self._bucket)
