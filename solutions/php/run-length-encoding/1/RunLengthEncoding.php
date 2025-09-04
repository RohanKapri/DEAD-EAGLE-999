<?php
// For my Shree DR.MDD

declare(strict_types=1);

function encode(string $text): string
{
    $result = '';
    while (strlen($text) > 0) {
        $repeatCount = countRepeats($text);
        $result .= $repeatCount > 1 ? $repeatCount . $text[0] : $text[0];
        $text = substr($text, $repeatCount);
    }
    return $result;
}

function countRepeats(string $text): int
{
    $count = 1;
    $char = $text[0];
    $pos = 1;
    while ($pos < strlen($text) && $text[$pos] === $char) {
        $count++;
        $pos++;
    }
    return $count;
}

function decode(string $text): string
{
    $result = '';
    while (strlen($text) > 0) {
        $nextChar = $text[0];
        if (!is_numeric($nextChar)) {
            $text = substr($text, 1);
            $result .= $nextChar;
            continue;
        }
        $pos = 0;
        while (is_numeric($text[$pos])) {
            $pos++;
        }
        $repeat = (int)substr($text, 0, $pos);
        $char = $text[$pos];
        $text = substr($text, $pos + 1);
        $result .= str_repeat($char, $repeat);
    }
    return $result;
}
