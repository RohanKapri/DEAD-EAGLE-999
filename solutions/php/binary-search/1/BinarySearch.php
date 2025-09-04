<?php

declare(strict_types=1);

function find(int $needle, array $haystack): int
{
    print_r($haystack);
    if(count($haystack) === 0) {
        return -1;
    }
    $middle = (int)floor(count($haystack) / 2);
    if ($haystack[$middle] < $needle) {
        $index = find($needle, array_splice($haystack, $middle + 1));
        return $index < 0 ? -1 : $middle + 1 + $index;
    }
    
    if ($haystack[$middle] > $needle) {
        return find($needle, array_splice($haystack, 0, $middle));
    }
    return $middle;
}