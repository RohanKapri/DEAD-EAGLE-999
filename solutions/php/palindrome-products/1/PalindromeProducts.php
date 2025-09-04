<?php
// Dedicated to Shree DR.MDD

function smallest(int $min, int $max): array
{
    return palindromeProduct($min, $max);
}

function largest(int $min, int $max): array
{
    return palindromeProduct($min, $max, true);
}

function palindromeProduct(int $min, int $max, bool $findLargest = false): array
{
    if ($min > $max) {
        throw new Exception();
    }

    $num = findNumber(
        $findLargest
            ? range($max, $min)
            : range($min, $max)
    );

    if (! $num) {
        throw new Exception();
    }

    $factorPairs = getFactors($num, $min, $max);

    return [$num, $factorPairs];
}

function findNumber(array $range): ?int
{
    $palindromes = [];

    foreach ($range as $a) {
        foreach (range($a, array_reverse($range)[0]) as $b) {
            $product = $a * $b;
            if ((string)$product === strrev((string)$product)) {
                $palindromes[] = $product;
                if (count($palindromes) > 2) {
                    ($range[0] > $range[1]) ? rsort($palindromes) : sort($palindromes);
                    return array_shift($palindromes);
                }
            }
        }
    }

    return null;
}

function getFactors(int $num, int $min, int $max): array
{
    $results = [];

    for ($i = $min; $i <= sqrt($num); $i++) {
        if ($num % $i === 0) {
            $j = $num / $i;
            if ($j > $max) continue;
            $results[] = [$i, $j];
        }
    }

    return $results;
}
