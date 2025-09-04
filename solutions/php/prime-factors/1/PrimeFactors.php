<?php

declare(strict_types=1);

function factors(int $number): array
{
    $factors = [];
    while($number > 1) {
        $factor = 2;
        while($number % $factor !== 0) {
            $factor++;
        }
        $factors[] = $factor;
        $number = (int)($number / $factor);
    }
    return $factors;
}