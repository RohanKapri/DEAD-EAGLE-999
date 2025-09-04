<?php

declare(strict_types=1);

function isArmstrongNumber(int $number): bool {
    return sumOfDigits($number) === $number; 
}

function sumOfDigits(int $number): int {
    $power = strlen((string)$number);
    return array_sum(array_map(function (string $digit) use ($power) {
        return ((int)$digit) ** $power;
    }, str_split((string)$number)));
}