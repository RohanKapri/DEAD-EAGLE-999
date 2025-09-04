<?php

declare(strict_types=1);

function maskify(string $cc): string
{
    $out= [];
    foreach(str_split($cc) as $i => $char) {
        if (!is_numeric($char) || $i === 0 || $i > strlen($cc) - 5) {
            $out[] = $char;
        } else {
            $out[] = '#';
        }
    }
    return implode($out);
}