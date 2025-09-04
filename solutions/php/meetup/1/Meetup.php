<?php

/*
 * By adding type hints and enabling strict type checking, code can become
 * easier to read, self-documenting and reduce the number of potential bugs.
 * By default, type declarations are non-strict, which means they will attempt
 * to change the original type to match the type specified by the
 * type-declaration.
 *
 * In other words, if you pass a string to a function requiring a float,
 * it will attempt to convert the string value to a float.
 *
 * To enable strict mode, a single declare directive must be placed at the top
 * of the file.
 * This means that the strictness of typing is configured on a per-file basis.
 * This directive not only affects the type declarations of parameters, but also
 * a function's return type.
 *
 * For more info review the Concept on strict type checking in the PHP track
 * <link>.
 *
 * To disable strict typing, comment out the directive below.
 */

declare(strict_types=1);

function meetup_day(int $year, int|string $month, string $which, string $weekday): DateTimeImmutable
{
    $month = (int)$month;
    $candidates = match ($which) {
        "teenth" => range(13, 19),
        "first" =>  range(1, 7),
        "second" => range(8, 14),
        "third" => range(15, 21),
        "fourth" => range(22, 28),
        "last" => range(22, 31)
    };

    $date = new DateTimeImmutable();
    $date = $date->setTime(0, 0, 0, 0);
    foreach (array_reverse($candidates) as $day) {
        $date = $date->setDate($year, $month, $day);
        if ($date->format("l") === $weekday && $date->format("n") == $month) {
            return $date;
        }
    }
}