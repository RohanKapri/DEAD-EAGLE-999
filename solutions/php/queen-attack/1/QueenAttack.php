<?php
declare(strict_types=1);
function placeQueen(int $xCoordinate, int $yCoordinate): bool
{
    if ($xCoordinate < 0 || $yCoordinate < 0) {
        throw new InvalidArgumentException('The rank and file numbers must be positive.');
    }
    if ($xCoordinate >= 8 || $yCoordinate >= 8) {
        throw new InvalidArgumentException('The position must be on a standard size chess board.');
    }
    return true;
}

function canAttack(array $whiteQueen, array $blackQueen): bool
{
    $sameLine = ($whiteQueen[0] === $blackQueen[0]) || ($whiteQueen[1] === $blackQueen[1]);
    $diagonal = (abs($whiteQueen[0] - $blackQueen[0]) === abs($whiteQueen[1] - $blackQueen[1]));
    return $sameLine || $diagonal;
}