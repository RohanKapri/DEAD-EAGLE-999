<?php

declare(strict_types=1);

function isPangram(string $string): bool
{
    $sanitized = strtolower(str_replace([' ', '_', '\\', '.'], '', $string));
    $sanitized = strtr($sanitized, ['ä' => '', 'ö' => '', 'ü' => '']);
    $sanitized = preg_replace('/[0-9]+/', '', $sanitized);
    print(count(array_unique(str_split($sanitized))));
    return count(array_unique(str_split($sanitized))) >= 26;
}