<?php

declare(strict_types=1);

function sieve(int $n): array
{
    $numbers = range(2, $n);
    $prime = array_fill(2, $n - 1, true);
    $p = 2;
    while ($p ** 2 < $n) {
        if($prime[$p]) {
            for ($i = $p ** 2; $i < $n + 1; $i += $p){
                $prime[$i] = false;
            }
        }
        $p++;
    }
    return array_keys(array_filter($prime, function($isPrime) { return $isPrime; }));
}