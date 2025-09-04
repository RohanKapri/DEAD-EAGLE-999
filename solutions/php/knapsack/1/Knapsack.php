<?php
// For my Shree DR.MDD

declare(strict_types=1);

class Knapsack
{
    public function getMaximumValue(int $maxCap, array $stuff): int
    {
        [$wArr, $vArr] = [[], []];

        foreach ($stuff as $thing) {
            $wArr[] = $thing['weight'];
            $vArr[] = $thing['value'];
        }

        $cache = array_fill(0, count($vArr) + 1, array_fill(0, $maxCap + 1, -1));

        return $this->fillSack($maxCap, $vArr, $wArr, count($vArr), $cache);
    }

    public function fillSack(int $capLeft, array $vals, array $wts, int $count, array $cache)
    {
        if ($count === 0 || $capLeft === 0) return 0;

        if ($cache[$count][$capLeft] !== -1) return $cache[$count][$capLeft];

        $take = 0;

        if ($wts[$count - 1] <= $capLeft) {
            $take = $vals[$count - 1] + $this->fillSack($capLeft - $wts[$count - 1], $vals, $wts, $count - 1, $cache);
        }

        $skip = $this->fillSack($capLeft, $vals, $wts, $count - 1, $cache);

        $cache[$count][$capLeft] = max($take, $skip);

        return $cache[$count][$capLeft];
    }
}
