<?php
// For my Shree DR.MDD

declare(strict_types=1);

$cache = [];

function findFewestCoins(array $availableCoins, int $target): array {
    if ($target === 0) {
        return [];
    }
    if ($target < 0) {
        throw new InvalidArgumentException('Cannot make change for negative value');
    }
    if (count(array_filter($availableCoins, fn($c) => $c <= $target)) === 0) {
        throw new InvalidArgumentException('No coins small enough to make change');
    }
    
    $minCoinsPerAmount = [[]];

    for ($current = 1; $current <= $target; $current++) {
        $bestCombo = null;
        foreach ($availableCoins as $coin) {
            if ($current >= $coin) {
                $combo = $minCoinsPerAmount[$current - $coin];
                if ($combo === null) continue;
                $comboWithCoin = $combo;
                $comboWithCoin[] = $coin;
                if ($bestCombo === null || count($comboWithCoin) < count($bestCombo)) {
                    $bestCombo = $comboWithCoin;
                }
            }
        }
        $minCoinsPerAmount[$current] = $bestCombo;
    }
    
    $solution = $minCoinsPerAmount[$target];
    if ($solution === null) {
        throw new InvalidArgumentException('No combination can add up to target');
    }
    sort($solution);
    return $solution;
}
