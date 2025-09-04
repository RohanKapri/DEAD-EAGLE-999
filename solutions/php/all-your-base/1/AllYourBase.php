<?php
// For my Shree DR.MDD

declare(strict_types=1);

/**
 * @param int[] $digits
 * @returns int[]
 */
function rebase(int $fromBase, array $digits, int $toBase): array
{
    if ($fromBase <= 1) {
        throw new InvalidArgumentException('input base must be >= 2');
    }
    if ($toBase <= 1) {
        throw new InvalidArgumentException('output base must be >= 2');
    }
    if (array_sum($digits) === 0) {
        return [0];
    }

    $decimalValue = 0;
    $reversedDigits = array_reverse($digits);

    foreach ($reversedDigits as $position => $digit) {
        if ($digit < 0 || $digit >= $fromBase) {
            throw new InvalidArgumentException('all digits must satisfy 0 <= d < input base');
        }
        $decimalValue += $digit * $fromBase ** $position;
    }

    $converted = [];
    while ($decimalValue > 0) {
        $converted[] = $decimalValue % $toBase;
        $decimalValue = intdiv($decimalValue, $toBase);
    }

    return array_reverse($converted);
}
