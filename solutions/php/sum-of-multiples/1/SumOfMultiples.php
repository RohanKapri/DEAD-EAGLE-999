<?php

declare(strict_types=1);

function sumOfMultiples(int $level, array $multiples): int {
    $sets = array_map(function ($multiple) use ($level) {
        $set = [];
        $i = 1;
        while($i * $multiple < $level && $multiple !== 0) {
            array_push($set, $i * $multiple);
            $i++;
        }
        return $set;
    }, $multiples);
    print_r($sets);
    $vals = array_reduce($sets, function($carry, $set) {
        return array_merge($carry, $set);
    }, []);
    $vals = array_unique($vals);
    return array_sum($vals);
}