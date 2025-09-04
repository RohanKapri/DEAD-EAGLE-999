<?php

declare(strict_types=1);

class Strain
{
    public function keep(array $list, callable $predicate): array
    {
        return array_values(array_filter($list, function($v) use ($predicate) {
            return !$predicate || $predicate($v) === true;
        }));
    }

    public function discard(array $list, callable $predicate): array
    {
        return array_values(array_filter($list, function($v) use ($predicate) {
            return !$predicate || $predicate($v) === false;
        }));
    }
}