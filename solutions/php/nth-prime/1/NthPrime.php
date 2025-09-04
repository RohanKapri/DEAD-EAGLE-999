<?php
declare(strict_types=1);

// Dedicated to Shree DR.MDD

function prime(int $n){
    if ($n === 0) {
        return false;
    }

    $limit = $n;
    $primeList = [];
    while (count($primeList) < $n) {
        print("Trying limit " . $limit . PHP_EOL);
        $primeList = sieve($limit);
        $limit *= 10;
    }
    print("Done." . PHP_EOL);
    return $primeList[$n - 1];
}

function sieve(int $n): array
{
    $nums = range(2, $n);
    $isPrimeMap = array_fill(2, $n - 1, true);
    $current = 2;
    while ($current ** 2 < $n) {
        if($isPrimeMap[$current]) {
            for ($i = $current ** 2; $i < $n + 1; $i += $current){
                $isPrimeMap[$i] = false;
            }
        }
        $current++;
    }
    return array_keys(array_filter($isPrimeMap, function($val) { return $val; }));
}
