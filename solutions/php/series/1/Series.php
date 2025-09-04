<?php

declare(strict_types=1);

function slices(string $digits, int $n): array
{
    if($n === 0 || $n > strlen($digits)) {
        throw new Exception();
    }
    $series = [];
    for($i = 0; $i < strlen($digits) - $n + 1; $i++) {
        array_push($series, substr($digits, $i , $n));
    }
    return $series;
}