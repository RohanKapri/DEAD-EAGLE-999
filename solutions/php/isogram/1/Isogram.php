<?php

declare(strict_types=1);

function isIsogram(string $word): bool
{
    $word = strtolower($word);
    $word = str_replace(array('-',' '), "", $word);
    for($i = 0; $i < mb_strlen($word) - 1; $i++) {
        for($j = $i + 1; $j < mb_strlen($word); $j++) {
            if (mb_substr($word, $i, 1) === mb_substr($word, $j, 1)) {
                return false;
            }
        }
    }
    return true;
}