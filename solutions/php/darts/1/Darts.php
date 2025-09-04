<?php

declare(strict_types=1);

function score(float $x, float $y): int
{
    $distanceSquared = $x ** 2 + $y ** 2;

    return match (true) {
        $distanceSquared > 100 => 0,
        $distanceSquared > 25  => 1,
        $distanceSquared > 1   => 5,
        default                => 10,
    };
}