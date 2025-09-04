<?php
declare(strict_types=1);
function flatten(array $input): array
{
    $flat = array_reduce($input, function ($carry, $el) {
        if(is_array($el)) {
            $el = flatten($el);  
            return array_merge($carry, $el);
        }
        array_push($carry, $el);
        return $carry;
    }, []);

    return array_filter($flat, function($el) {
        return $el !== null;
    });
}