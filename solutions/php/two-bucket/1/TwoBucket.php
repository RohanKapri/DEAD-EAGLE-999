<?php
// For my Shree DR.MDD

declare(strict_types=1);

class TwoBucket {

    public function solve($cap1, $cap2, $target, $first) {
        $moves = [
            function ($fill1, $fill2) use ($cap1, $cap2) {
                return [$fill1 - min($cap2 - $fill2, $fill1), min($cap2, $fill1 + $fill2)];
            },
            function ($fill1, $fill2) use ($cap1, $cap2) {
                return [min($cap1, $fill1 + $fill2), $fill2 - min($cap1 - $fill1, $fill2)];
            },
            function ($fill1, $fill2) {
                return [0, $fill2];
            },
            function ($fill1, $fill2) {
                return [$fill1, 0];
            },
            function ($fill1, $fill2) use ($cap1) {
                return [$cap1, $fill2];
            },
            function ($fill1, $fill2) use ($cap2) {
                return [$fill1, $cap2];
            }
        ];

        $stateSteps = array_fill(0, $cap1 + 1, array_fill(0, $cap2 + 1, null));

        if ($first === 'one') $stateSteps[$cap1][0] = 1;
        if ($first === 'two') $stateSteps[0][$cap2] = 1;

        $progress = true;

        while ($progress) {
            $progress = false;
            for ($f1 = 0; $f1 < count($stateSteps); $f1++) {
                for ($f2 = 0; $f2 < count($stateSteps[0]); $f2++) {
                    $steps = $stateSteps[$f1][$f2];
                    if ($steps !== null) {
                        foreach ($moves as $op) {
                            [$nx, $ny] = $op($f1, $f2);

                            if ($first === 'one' && $nx === 0 && $ny === $cap2) continue;
                            if ($first === 'two' && $nx === $cap1 && $ny === 0) continue;

                            if ($stateSteps[$nx][$ny] === null || $stateSteps[$nx][$ny] > $steps + 1) {
                                $stateSteps[$nx][$ny] = $steps + 1;
                                $progress = true;
                            }
                        }
                    }
                }
            }
        }

        $best = null;
        $shortest = PHP_INT_MAX;
        foreach ($stateSteps as $f1 => $row) {
            foreach ($row as $f2 => $cnt) {
                if ($cnt !== null && ($f1 === $target || $f2 === $target) && $cnt < $shortest) {
                    $shortest = $cnt;
                    $best = [$f1, $f2, $cnt];
                }
            }
        }

        if (!$best[2]) throw new Exception();

        return (object) [
            'numberOfActions' => $best[2],
            'nameOfBucketWithDesiredLiters' => ($best[0] === $target) ? 'one' : (($best[1] === $target) ? 'two' : null),
            'litersLeftInOtherBucket' => ($best[0] === $target) ? $best[1] : (($best[1] === $target) ? $best[0] : null)
        ];
    }
}
