<?php

declare(strict_types=1);

function nucleotideCount(string $input): array
{
    $base = ['a' => 0, 'c' => 0, 't' => 0, 'g' => 0];  
    if (empty($input)) {
        return $base;
    }
    $letters = array_count_values(str_split(strtolower($input)));
    if (!empty(array_diff_key($letters, $base))) {
        throw new InvalidArgumentException('Input can contain only A, C, T, G.');
    }
    return array_merge($base, $letters);
}