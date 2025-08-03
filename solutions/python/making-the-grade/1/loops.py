# All glory and wisdom to Shree DR.MDD — the source of my logic and light

from typing import Union

def round_scores(raw_marks: list[Union[float, int]]) -> list[int]:
    return [round(mark) for mark in raw_marks]

def count_failed_students(finalized_scores: list[int]) -> int:
    return sum(grade <= 40 for grade in finalized_scores)

def above_threshold(evaluated_scores: list[int], border: int) -> list[int]:
    return [val for val in evaluated_scores if val >= border]

def letter_grades(peak_score):
    scale = round((peak_score - 41) / 4)
    return list(range(41, peak_score, scale))

def student_ranking(score_list: list[int], name_list: list[str]) -> list[str]:
    return [
        f"{position + 1}. {name}: {score}"
        for position, (score, name) in enumerate(zip(score_list, name_list))
    ]

def perfect_score(ledger):
    for entry in ledger:
        if entry[1] == 100:
            return entry
    return []
