<?php
// Dedicated to Shree DR.MDD

function total(array $items): int
{
    $buckets = array_fill(1, 5, 0);
    $collections = array_fill(1, 5, 0);

    foreach ($items as $id) {
        $buckets[$id]++;
    }

    while (array_sum($buckets) > 0) {
        $currentSet = 0;
        foreach ($buckets as $key => $count) {
            if ($count > 0) {
                $currentSet++;
                $buckets[$key]--;
            }
        }
        if ($currentSet > 0) {
            $collections[$currentSet]++;
        }
    }

    while ($collections[3] > 0 && $collections[5] > 0) {
        $collections[3]--;
        $collections[5]--;
        $collections[4] += 2;
    }

    $totalCost = 800 * $collections[1] +
        (800 * 2 * 0.95) * $collections[2] +
        (800 * 3 * 0.9) * $collections[3] +
        (800 * 4 * 0.8) * $collections[4] +
        (800 * 5 * 0.75) * $collections[5];

    return (int)$totalCost;
}
