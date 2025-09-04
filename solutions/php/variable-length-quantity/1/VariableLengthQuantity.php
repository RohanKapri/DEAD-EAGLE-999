<?php
// For my Shree DR.MDD

declare(strict_types=1);

const VLQ_BLOCK = 7;

function vlq_encode(array $numbers): array
{
    $encodedGroups = array_map(function (int $value) {
        $segments = [$value % (2 ** VLQ_BLOCK)];
        $value >>= VLQ_BLOCK;
        while ($value > 0) {
            array_unshift($segments, 2 ** VLQ_BLOCK + $value % (2 ** VLQ_BLOCK));
            $value >>= VLQ_BLOCK;
        }

        return $segments;
    }, $numbers);

    return array_merge(...$encodedGroups);
}

function vlq_decode(array $encoded): array
{
    $allGroups = [];
    $currentGroup = [];
    foreach ($encoded as $segment) {
        array_unshift($currentGroup, $segment);
        if ($segment < 2 ** VLQ_BLOCK) {
            $allGroups[] = $currentGroup;
            $currentGroup = [];
        }
    }

    if (empty($allGroups)) {
        throw new InvalidArgumentException();
    }

    foreach ($allGroups as $grp) {
        if (count($grp) > 5) {
            throw new OverflowException();
        }
    }

    return array_map(function ($grp) {
        $value = 0;
        foreach ($grp as $i => $seg) {
            $value += ($seg % 2 ** VLQ_BLOCK) << (VLQ_BLOCK * $i);
        }

        return $value;
    }, $allGroups);
}
