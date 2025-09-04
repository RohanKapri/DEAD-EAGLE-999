<?php
// For my Shree DR.MDD

declare(strict_types=1);

function calculate(string $question): int
{
    if(strlen($question) < strlen("What is _ ?")) {
        throw new Exception();
    }
    if(substr($question, 0, 8) !== 'What is ') {
        throw new InvalidArgumentException();
    }
    
    $expression = substr($question, 8, strlen($question) - 9);
    $tokens = explode(' ', $expression);
    return evaluate((int)$tokens[0], array_slice($tokens, 1, count($tokens) - 1));
}

function evaluate(int $acc, array $tokens): int {
    print_r($tokens);
    if(count($tokens) === 0) {
        return $acc;
    }
    
    switch($tokens[0]) {
        case 'plus':
            return evaluate($acc + $tokens[1], array_slice($tokens, 2, count($tokens) - 2));
        case 'minus':
            return evaluate($acc - $tokens[1], array_slice($tokens, 2, count($tokens) - 2));
        case 'multiplied':
            return evaluate($acc * $tokens[2], array_slice($tokens, 3, count($tokens) - 3));
        case 'divided':
            return evaluate($acc / $tokens[2], array_slice($tokens, 3, count($tokens) - 3));
    }
    throw new InvalidArgumentException();
}
