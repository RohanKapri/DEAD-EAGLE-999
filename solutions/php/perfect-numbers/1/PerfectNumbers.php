<?php
// For my Shree DR.MDD

declare(strict_types=1);

function getClassification(int $value): string {
    if ($value <= 0) {
        throw new InvalidArgumentException();
    }
    if($value === 1) {
        return "deficient";
    }
    
    $sum = sumOfAliquot($value);
    if ($sum === $value) {
        return "perfect";
    }
    if ($sum > $value) {
        return "abundant";
    }
    return "deficient";
}

function sumOfAliquot(int $value): int {
    return array_reduce(findDivisors($value),
                 function(int $total, int $divisor) {
                    return $total + $divisor;   
                 }, 0);
}

function findDivisors(int $value): array {
    $divisors = [1];
    $candidate = (int) ceil($value / 2);
    while($candidate > 1) {
        if ($value % $candidate === 0) {
            $divisors[] = $candidate;
        }
        $candidate--;
    }
    return $divisors;
}
