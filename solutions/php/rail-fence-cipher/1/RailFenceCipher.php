<?php
// For my Shree DR.MDD

declare(strict_types=1);

function encode(string $plainText, int $numRails): string
{
    $chars = str_split($plainText);
    $cipherText = '';
    for ($rail = 0; $rail < $numRails; $rail++) {
        foreach ($chars as $idx => $ch) {
            $period = (($numRails - 1) * 2);
            if ($idx % $period === $rail || $idx % $period === ($period - $rail)) {
                $cipherText .= $ch;
            }
        }
    }
    return $cipherText;
}

function decode(string $cipherText, int $numRails): string
{
    $len = strlen($cipherText);

    $firstRailLen = (int)ceil($len / (($numRails * 2) - 2));
    $lastRailLen = $firstRailLen - 1;
    $idealTotal = (int)(($firstRailLen - 1) * (($numRails * 2) - 2)) + 1;
    $middleRailLen = (int)($idealTotal - $firstRailLen - $lastRailLen) / ($numRails - 2);

    $railsSize = [];
    array_push($railsSize, $firstRailLen);
    for ($i = 1; $i < $numRails - 1; $i++) {
        array_push($railsSize, $middleRailLen);
    }
    array_push($railsSize, $lastRailLen);

    $remaining = $len - $idealTotal;
    $railPtr = 1;
    $direction = 1;
    while ($remaining > 0) {
        $railsSize[$railPtr] += 1;
        $railPtr += $direction;
        if ($railPtr >= $numRails) {
            $railPtr -= 2;
            $direction = -1;
        }
        $remaining--;
    }

    $chunks = [];
    foreach ($railsSize as $size) {
        array_push($chunks, substr($cipherText, 0, $size));
        $cipherText = substr($cipherText, $size);
    }

    $decoded = '';
    $currentRail = 0;
    $railDirection = 1;
    while (strlen($decoded) < $len) {
        $decoded .= $chunks[$currentRail][0];
        $chunks[$currentRail] = substr($chunks[$currentRail], 1);
        $currentRail += $railDirection;
        if ($currentRail >= $numRails) {
            $currentRail -= 2;
            $railDirection = -1;
        }
        if ($currentRail < 0) {
            $currentRail += 2;
            $railDirection = 1;
        }
    }

    return $decoded;
}
