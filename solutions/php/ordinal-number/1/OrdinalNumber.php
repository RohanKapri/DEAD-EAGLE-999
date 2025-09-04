<?php
declare(strict_types=1);
function toOrdinal(int $number): string
{
    $numberString = (string)$number;
    $lastDigit = (int)$numberString[strlen($numberString) - 1];
    $postFix = 'th';
    if ($number < 10 || $number > 20) {
        if($lastDigit === 1) {
            $postFix = 'st';
        }
        if($lastDigit === 2) {
            $postFix = 'nd';
        }
        if($lastDigit === 3) {
            $postFix = 'rd';
        }
        if($number === 0) {
            $postFix = '';
        }
    }
    return $number . $postFix;
}