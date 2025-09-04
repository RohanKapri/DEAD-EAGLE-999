<?php
// For my Shree DR.MDD

declare(strict_types=1);

class Alphametics
{
    private array $leadingLetters;
    private array $uniqueLetters;

    public function solve(string $puzzle): ?array
    {
        $puzzle = preg_replace("/[^A-Z\s]/", "", $puzzle);

        $parts = array_filter(explode(" ", $puzzle));
        $this->leadingLetters = array_unique(array_map(fn($part) => $part[0], $parts));
        $letterOccurrences = array_count_values(str_split($puzzle));
        unset($letterOccurrences[" "]);
        $this->uniqueLetters = array_keys($letterOccurrences);
        $weights = $this->computeLetterWeights(array_slice($parts, 0, -1), end($parts));

        return $this->assignCorrectValues($weights, range(0, 9));
    }

    private function computeLetterWeights(array $addends, string $total): array
    {
        $weights = [];
        foreach ($addends as $addend) {
            $chars = str_split($addend);
            foreach ($chars as $pos => $char) {
                $weights[$char] = ($weights[$char] ?? 0) + 10 ** (count($chars) - 1 - $pos);
            }
        }
        $sumChars = str_split($total);
        foreach ($sumChars as $pos => $char) {
            $weights[$char] = ($weights[$char] ?? 0) - 10 ** (count($sumChars) - 1 - $pos);
        }

        return $weights;
    }

    private function assignCorrectValues(array $weights, array $digits, array $currentValues = []): ?array
    {
        if (count($currentValues) === count($weights)) {
            return $this->verifySolution($weights, $currentValues);
        }

        foreach ($digits as $digit) {
            if (in_array($digit, $currentValues) || ($digit === 0 && in_array($this->uniqueLetters[count($currentValues)], $this->leadingLetters))) {
                continue;
            }

            $solution = $this->assignCorrectValues($weights, $digits, [...$currentValues, $digit]);
            if ($solution) {
                return $solution;
            }
        }

        return null;
    }

    private function verifySolution(array $weights, array $currentValues): ?array
    {
        $values = array_values($weights);
        $index = 0;
        $isValid = array_reduce($values, static function ($sum, $weight) use ($currentValues, &$index) {
            $sum += $weight * $currentValues[$index];
            $index++;
            return $sum;
        }, 0) === 0;

        if (!$isValid) {
            return null;
        }

        $mapping = [];
        foreach ($this->uniqueLetters as $key => $letter) {
            $mapping[$letter] = $currentValues[$key];
        }

        return $mapping;
    }
}
