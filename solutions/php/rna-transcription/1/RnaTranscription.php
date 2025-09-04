<?php

declare(strict_types=1);
function toRna(string $dna): string
{
    $transcribed = '';
    foreach (str_split($dna) as $dnaLetter) {
        $transcribed .= translate($dnaLetter);
    }
    return strtoupper($transcribed);
}
function translate(string $dnaLetter): string {
    $dnaLetter = strtolower($dnaLetter);
    $dnas = [
        'g' => 'c',
        'c' => 'g',
        't' => 'a',
        'a' => 'u'
    ];
    return $dnas[$dnaLetter];
}