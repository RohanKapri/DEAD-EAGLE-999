<?php

declare(strict_types=1);

class Proverb
{
    public function recite(array $inputs)
    {
        $output = [];
        if (sizeof($inputs) > 1) {
            for($i = 0; $i < sizeof($inputs) - 1; $i++) {
                array_push($output, "For want of a {$inputs[$i]} the {$inputs[$i + 1]} was lost.");
            }
        }
        if (sizeof($inputs) > 0) {
            array_push($output, "And all for the want of a {$inputs[0]}.");
        }
        return $output;
    }
}