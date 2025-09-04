<?php

declare(strict_types=1);

function isValid(string $number)
{
    $number = strrev(str_replace(' ', '', $number));
    $sum = 0;
    for($i = 0; $i < strlen($number); $i++){
        $digit = (int)$number[$i];
        if ($i % 2 === 1) {
            $digit = ($digit * 2 );
            if ($digit > 9) {
                $digit -= 9;
            }
        }
        $sum += $digit;
    }
    return ($sum % 10) === 0 && strlen($number) > 1 && strlen(preg_replace('/[0-9]+/', '', $number)) === 0;
}