<?php

declare(strict_types=1);

function wordCount(string $words): array
{
    $sanitized = strtolower($words);
    $sanitized = str_replace(["'", ":", ",", "@", "!", "$", "&", "%", "^"], "", $sanitized);
    $sanitized = str_replace(["\t", "\n"], " ", $sanitized);

    $list = [];
    foreach(explode(" ", $sanitized) as $word) {
        if ($word === "") {
            continue;
        }
        if(!array_key_exists($word, $list)) {
            $list[$word] = 0;
        }
        $list[$word]++;
    }
    return $list;
}