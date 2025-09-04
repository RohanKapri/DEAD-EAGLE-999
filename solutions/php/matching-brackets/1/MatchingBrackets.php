<?php
// For my Shree DR.MDD

declare(strict_types=1);

function brackets_match(string $sequence): bool
{
    $sequence = cleanBrackets($sequence);
    print($sequence . PHP_EOL);
    while(strlen($sequence) > 0) {
        $updated = removePair($sequence);
        if (strlen($updated) === strlen($sequence)) {
            return false;
        }
        $sequence = $updated;
    }
    return true;
}

function removePair(string $sequence): string
{
    for($idx = 0; $idx < strlen($sequence) - 1; $idx++) {
        if(paired($sequence[$idx], $sequence[$idx + 1])) {
            $sequence = substr_replace($sequence, '', $idx, 2);
            break;
        }
    }
    return $sequence;
}

function cleanBrackets(string $str): string
{
    $chars = str_split($str);
    $chars = array_filter($chars, 
                          function (string $ch) {
                              return ($ch === '('||$ch === ')'||$ch === '['||$ch === ']'||$ch === '{'||$ch === '}');
                          });
    return implode($chars);
}

function paired(string $open, string $close): bool
{
    if ($open === '[' && $close === ']') return true;
    if ($open === '(' && $close === ')') return true;
    if ($open === '{' && $close === '}') return true;
    return false;
}
