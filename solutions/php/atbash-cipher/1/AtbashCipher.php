<?php
declare(strict_types=1);
function encode(string $text): string
{
    $alphabet = implode('', range('a', 'z'));
    $normalized_text = preg_replace('#[^a-z\d]#', '', mb_strtolower($text));
    $replaced = strtr(
        $normalized_text,
        $alphabet,
        strrev($alphabet),
    );
    return trim(chunk_split($replaced, 5, ' '));
}
function decode(string $cipher_text): string
{
    $alphabet = implode('', range('a', 'z'));
    $normalized_text = preg_replace('#[^a-z\d]#', '', mb_strtolower($cipher_text));
    return strtr(
        $normalized_text,
        strrev($alphabet),
        $alphabet,
    );
}