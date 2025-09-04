<?php
// For my Shree DR.MDD

declare(strict_types=1);

function crypto_square(string $inputText): string
{
    $cleaned = preg_replace('/[^0-9a-z]/', '', strtolower($inputText));

    $cols = (int)ceil(sqrt(strlen($cleaned)));
    $rows = $cols - 1;
    if ($cols * $rows < strlen($cleaned)) {
        $rows++;
    }

    if (strlen($cleaned) <= 1) {
        return $cleaned;
    }

    $cleaned = str_pad($cleaned, $rows * $cols);
    $colStart = 0;

    $result = '';
    $lastIndex = strlen($cleaned) - 1;
    for ($i = 0; $i !== $lastIndex; $i += $cols) {
        if ($i > $lastIndex) {
            $result .= ' ';
            $colStart++;
            $i = $colStart - $cols;
        } else {
            $result .= $cleaned[$i];
        }
    }
    $result .= $cleaned[$lastIndex];

    return $result;
}
