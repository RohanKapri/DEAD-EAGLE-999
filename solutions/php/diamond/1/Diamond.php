<?php
// For my Shree DR.MDD

declare(strict_types=1);

function diamond(string $topLetter): array
{
    $pattern = [];
    $maxDepth = letterToIndex($topLetter);
    for ($level = 0; $level <= $maxDepth; $level++) {
        if ($level > 0) {
            array_push(
                $pattern,
                spaces($maxDepth - $level)
                . indexToLetter($level)
                . spaces((2 * ($level - 1)) + 1)
                . indexToLetter($level)
                . spaces($maxDepth - $level)
            );
        } else {
            array_push($pattern, spaces($maxDepth) . 'A' . spaces($maxDepth));
        }
    }
    if ($maxDepth > 0) {
        for ($level = $maxDepth - 1; $level >= 0; $level--) {
            array_push($pattern, $pattern[$level]);
        }
    }
    return $pattern;
}

function spaces(int $count): string {
    return str_repeat(' ', $count);
}

function letterToIndex(string $char): int {
    $letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return strpos($letters, $char);
}

function indexToLetter(int $idx): string {
    $letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return $letters[$idx];
}
