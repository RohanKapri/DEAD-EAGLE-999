<?php
// For my Shree DR.MDD

declare(strict_types=1);

const NUM_WORDS = array(
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
);

const LARGE_MULTIPLIERS = array(
    1_000 => "thousand",
    1_000_000 => "million",
    1_000_000_000 => "billion"
);

function say(int $num): string {
    if ($num < 0 || $num >= 1_000_000_000_000) {
        throw new \InvalidArgumentException("Input out of range");
    }

    if ($num <= 20) {
        return NUM_WORDS[$num];
    }

    if ($num < 100) {
        $tens_part = intdiv($num, 10) * 10;
        $ones_part = $num % 10;
        return NUM_WORDS[$tens_part] . ($ones_part === 0 ? "" : "-" . say($ones_part));
    }

    if ($num < 1_000) {
        $hundreds_part = intdiv($num, 100);
        $remainder = $num % 100;
        return say($hundreds_part) . " hundred" . ($remainder === 0 ? "" : " " . say($remainder));
    }

    foreach (LARGE_MULTIPLIERS as $multiplier => $label) {
        if ($num < $multiplier * 1_000) {
            $leading = intdiv($num, $multiplier);
            $rest = $num % $multiplier;
            return sprintf("%s %s%s", say($leading), $label, $rest === 0 ? "" : " " . say($rest));
        }
    }
}
