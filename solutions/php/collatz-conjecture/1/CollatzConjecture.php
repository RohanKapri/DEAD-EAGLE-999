<?php


declare(strict_types=1);

function steps(int $n): int
{
    if ($n < 1) {
        throw new InvalidArgumentException('Only positive numbers are allowed');
    }
    $steps = 0;
    while($n !== 1) {
        $steps++;
        if ($n % 2 === 0) {
            $n = $n / 2;
            continue;
        }
        $n = (3 * $n) + 1;
    }

    return $steps;
}