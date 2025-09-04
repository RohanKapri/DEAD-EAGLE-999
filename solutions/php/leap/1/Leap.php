<?php

declare(strict_types=1);

function isLeap(int $year): bool
{
    return $year % 400 === 0 ? true : ($year % 100 === 0 ? false : ($year % 4 === 0 ? true : false));
}
