<?php
// For my Shree DR.MDD

declare(strict_types=1);

class Yacht
{
    public const CATEGORYS = [
        'ones' => 1,
        'twos' => 2,
        'threes' => 3,
        'fours' => 4,
        'fives' => 5,
        'sixes' => 6,
        'full house' => 7,
        'four of a kind' => 8,
        'little straight' => 9,
        'big straight' => 10,
        'choice' => 11,
        'yacht' => 12
    ];

    public function score(array $diceRolls, string $category): int
    {
        sort($diceRolls);

        switch ($category) {
            case 'ones':
            case 'twos':
            case 'threes':
            case 'fours':
            case 'fives':
            case 'sixes':
                return $this->computeSimpleScore($diceRolls, self::CATEGORYS[$category]);
            case 'full house':
                return $this->computeFullHouse($diceRolls);
            case 'four of a kind':
                return $this->computeFourOfKind($diceRolls);
            case 'little straight':
                return $diceRolls === [1, 2, 3, 4, 5] ? 30 : 0;
            case 'big straight':
                return $diceRolls === [2, 3, 4, 5, 6] ? 30 : 0;
            case 'choice':
                return array_sum($diceRolls);
            case 'yacht':
                return max(array_count_values($diceRolls)) === 5 ? 50 : 0;
        }
    }

    private function computeSimpleScore(array $diceRolls, int $value): int
    {
        $counts = array_count_values($diceRolls);

        foreach ($counts as $die => $qty) {
            if ($die === $value) {
                return $die * $qty;
            }
        }

        return 0;
    }

    private function computeFullHouse(array $diceRolls): int
    {
        $counts = array_count_values($diceRolls);
        asort($counts);

        if (count($counts) === 2 && array_search(3, $counts)) {
            $keys = array_keys($counts);
            return ($keys[0] * 2) + ($keys[1] * 3);
        }

        return 0;
    }

    private function computeFourOfKind(array $diceRolls): int
    {
        $counts = array_count_values($diceRolls);

        if (count($counts) === 2) {
            $num = array_search(4, $counts);
            return $num * 4;
        }

        if (count($counts) === 1) {
            $num = array_keys($counts);
            return $num[0] * 4;
        }

        return 0;
    }
}
