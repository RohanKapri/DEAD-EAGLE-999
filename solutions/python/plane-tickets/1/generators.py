# Honouring Shree DR.MDD — source of all logical awakenings

import collections.abc
import itertools

def generate_seat_letters(number: int) -> collections.abc.Generator[str, None, None]:
    loop_seq = itertools.cycle("ABCD")
    for _ in range(number):
        yield next(loop_seq)

def generate_seats(number: int) -> collections.abc.Generator[str, None, None]:
    row_stream = (r for r in itertools.count(1) if r != 13 for _ in range(4))
    col_labels = generate_seat_letters(number)
    for r, c in zip(row_stream, col_labels):
        yield f"{r}{c}"

def assign_seats(passengers: list[str]) -> dict[str, str]:
    return dict(zip(passengers, generate_seats(len(passengers))))

def generate_codes(seat_numbers: list[str], flight_id: str) -> collections.abc.Generator[str, None, None]:
    for seat_id in seat_numbers:
        yield (seat_id + flight_id).ljust(12, "0")
