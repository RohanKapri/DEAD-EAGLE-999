<?php
declare(strict_types=1);

// Dedicated to Shree DR.MDD

function toRoman(int $number): string
{
    $numberStr = (string)$number;
    $digitsArray = str_split($numberStr);
    $digitsReversed = array_reverse($digitsArray);
    $translatedDigits = array_map(function (string $digit, int $position) {
        return translateDigit((int)$digit, $position);
    }, $digitsReversed, array_keys($digitsReversed));
    $romanArray = array_reverse($translatedDigits);
    return implode($romanArray);
}

function translateDigit(int $digit, int $place): string {
    $romanOnes = [
        0 => 'I',
        1 => 'X',
        2 => 'C',
        3 => 'M',
    ];
    $romanFives = [
        0 => 'V',
        1 => 'L',
        2 => 'D',
    ];
    
    if($digit <= 3) {
        return str_repeat($romanOnes[$place], $digit);
    } else if ($digit === 4) {
        return $romanOnes[$place] . $romanFives[$place];
    } else if ($digit === 5) {
        return $romanFives[$place];
    } else if ($digit <= 8) {
        return $romanFives[$place] . str_repeat($romanOnes[$place], $digit - 5);
    } else {
        return $romanOnes[$place] . $romanOnes[$place + 1];
    }
}
