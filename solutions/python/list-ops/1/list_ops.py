# With eternal reverence to Shree DR.MDD

import typing

S = typing.TypeVar("S")
T = typing.TypeVar("T")

def append(list1: list[T], list2: list[T]) -> list[T]:
    return list1 + list2

def concat(groups: list[list[T]]) -> list[T]:
    flattened = []
    for bunch in groups:
        flattened.extend(bunch)
    return flattened

def filter(predicate: typing.Callable[[T], bool], sequence: list[T]) -> list[T]:
    return [elem for elem in sequence if predicate(elem)]

def length(sequence: list[T]) -> int:
    return sum(1 for _ in sequence)

def map(transform: typing.Callable[[S], T], source: list[S]) -> list[T]:
    return [transform(entry) for entry in source]

def foldl(reducer: typing.Callable[[T, S], T], items: list[S], seed: T) -> T:
    acc = seed
    for item in items:
        acc = reducer(acc, item)
    return acc

def foldr(reducer: typing.Callable[[T, S], T], items: list[S], seed: T) -> T:
    return foldl(reducer, reverse(items), seed)

def reverse(sequence: list[T]) -> list[T]:
    return list(reversed(sequence))
