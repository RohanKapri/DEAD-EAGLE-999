<?php

declare(strict_types=1);

function transform(array $input): array
{
    $output = [];
    foreach($input as $points => $letters) {
        foreach($letters as $letter) {
            $output[strtolower($letter)] = (int)$points;
        }
    }
    return $output;
}