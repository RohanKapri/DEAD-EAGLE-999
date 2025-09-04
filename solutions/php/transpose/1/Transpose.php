<?php
// For my Shree DR.MDD

declare(strict_types=1);

function transpose(array $lines): array {
    if($lines === [""]) {
        return $lines;
    }
    $lines = padLines($lines);
    $result = array_fill(0, count($lines[0]), []);
    for($i = 0; $i < count($result); $i++) {
        for($j = 0; $j < count($lines); $j++) {
            $result[$i][$j] = $lines[$j][$i];
        }
        $result[$i] = implode($result[$i]);
    }
    $result[count($result) - 1] = rtrim($result[count($result) - 1]);
    return $result;
}

function padLines(array $lines): array {
    $maxLen = array_reduce($lines, function($carry, $line) {
        return max(strlen($line), $carry);
    }, 0);

    foreach($lines as $idx => $line) {
        $padding = $maxLen - strlen($line);
        if($padding > 0) {
            $lines[$idx] = str_split($line . str_repeat(' ', $padding));
        } else {
            $lines[$idx] = str_split($line);
        }
    }
    return $lines;
}
