<?php
declare(strict_types=1);
function detectAnagrams(string $word, array $anagrams): array
{
    return array_values(array_filter($anagrams, 
                                     function ($candidate) use ($word) {
                                         return computeLetterCount($word) == computeLetterCount($candidate) && 
                                strtolower($word) !== strtolower($candidate);
    }));
}
function computeLetterCount($word): array {
    $count = [];
    foreach(str_split(strtolower($word)) as $letter) {
        if(!array_key_exists($letter, $count)) {
            $count[$letter] = 0;
        }
        $count[$letter]++;   
    }
    return $count;
}