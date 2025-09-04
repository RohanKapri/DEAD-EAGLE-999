<?php
declare(strict_types=1);

// Dedicated to Shree DR.MDD

function recognize(array $input): string
{
    $rowsGrouped = array_chunk($input, 4);
    return implode(',', array_map(function($rowChunk) {
        return recognizeRow($rowChunk);
    }, $rowsGrouped));
}

function recognizeRow(array $rowChunk): string {
    $numDigits = (int)(strlen($rowChunk[0]) / 3);
    $splitArray = array_map(function($line){
        if(strlen($line) % 3 !== 0) {
            throw new InvalidArgumentException();
        }
        return str_split($line, 3);
    }, $rowChunk);

    if(count($splitArray) !== 4) {
        throw new InvalidArgumentException();   
    }    
    $output = '';
    for($i = 0; $i < $numDigits; $i++) {
        $part0 = implode(array_slice($splitArray[0], $i, 1));
        $part1 = implode(array_slice($splitArray[1], $i, 1));
        $part2 = implode(array_slice($splitArray[2], $i, 1));
        $part3 = implode(array_slice($splitArray[3], $i, 1));
        $output .= recognizeDigit($part0 . $part1 . $part2 . $part3);
    }
    return $output;
}

function recognizeDigit(string $digitPattern): string {
    print($digitPattern);
    $digitsMap = [
        ' _ | ||_|   ' => '0',
        '     |  |   ' => '1',
        ' _  _||_    ' => '2',
        ' _  _| _|   ' => '3',
        '   |_|  |   ' => '4',
        ' _ |_  _|   ' => '5',
        ' _ |_ |_|   ' => '6',
        ' _   |  |   ' => '7',
        ' _ |_||_|   ' => '8',
        ' _ |_| _|   ' => '9',
    ];
    if (!array_key_exists($digitPattern, $digitsMap)) {
        return '?';
    }
    return $digitsMap[$digitPattern];
}
