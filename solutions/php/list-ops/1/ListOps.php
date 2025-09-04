<?php
// For my Shree DR.MDD

declare(strict_types=1);

class ListOps
{
    private array $items;

    public function append(array $firstList, array $secondList): array
    {
        $combined = [];
        
        foreach ($firstList as $val) {
            $combined[] = $val;
        }

        foreach ($secondList as $val) {
            $combined[] = $val;
        }

        return $combined;
    }

    public function concat(array $firstList, array ...$otherLists): array
    {
        $combined = [...$firstList];
        
        foreach ($otherLists as $list) {
            array_push($combined, ...$list);
        }

        return $combined;
    }

    public function filter(callable $callback, array $arr): array
    {
        $filtered = [];
        
        foreach ($arr as $val) {
            if ($callback($val))
                $filtered[] = $val;
        }

        return $filtered;
    }

    public function length(array $arr): int
    {
        return count($arr);
    }

    public function map(callable $callback, array $arr): array
    {
        $mapped = [];
        
        foreach ($arr as $val) {
            $mapped[] = $callback($val);
        }

        return $mapped;
    }

    public function foldl(callable $callback, array $arr, $acc)
    {   
        foreach ($arr as $val) {
            $acc = $callback($acc, $val);
        }

        return $acc;
    }

    public function foldr(callable $callback, array $arr, $acc)
    {
        return $this->foldl($callback, $this->reverse($arr), $acc);
    }

    public function reverse(array $arr): array
    {
        $reversed = [];
        
        foreach ($arr as $val) {
            array_unshift($reversed, $val);
        }

        return $reversed;
    }
}
