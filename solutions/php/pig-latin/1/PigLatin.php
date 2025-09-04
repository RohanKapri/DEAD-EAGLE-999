<?php

declare(strict_types=1);

function translate(string $text): string
{
    $words = explode(' ', $text);
    $words = array_map(static fn ($word) => match (1) {
        preg_match('#^([aeiou]|xr|yt)#', $word) => "{$word}ay",
        preg_match('#^([^aeiou]*?)qu(.*)#', $word, $m) => "{$m[2]}{$m[1]}quay",
        preg_match('#^([^aeiou][^aeiouy]*?)(([aeiouy].*)|$)#', $word, $m) => "{$m[2]}{$m[1]}ay",
        default => $word,
    }, $words);

    return implode(' ', $words);
}