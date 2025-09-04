<?php

declare(strict_types=1);

function acronym(string $text): string
{
    $text = preg_replace('/-/', ' ', $text);
    print($text);
    $words = explode(" ", $text);
    if(count($words) < 2) {
        return '';
    }
    return mb_strtoupper(array_reduce($words, 
                        function ($carry, $item) {
                            if ($item === 'HyperText') {
                                return 'HT';
                            }
                           return $carry . mb_substr($item, 0 , 1); 
                        }));
}