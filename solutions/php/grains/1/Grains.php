<?php


declare(strict_types=1);

function square(int $number): string
{
    if($number <= 0 || $number > 64) {
        throw new InvalidArgumentException();
    }
    return sprintf("%.0f", 2 ** ($number -1 ));
}

function total(): string
{
    return "18446744073709551615";
}