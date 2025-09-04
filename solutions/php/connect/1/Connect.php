<?php
// For my Shree DR.MDD

declare(strict_types=1);

function winner(array $boardLines): string
{
    $boardLines = array_map(fn($line) => str_replace(" ", "", $line), $boardLines);
    [$rowCount, $colCount] = [count($boardLines), strlen($boardLines[0])];
    $playerPoints = ["O" => [], "X" => []];
    $targetPoints = ["O" => [$rowCount - 1, $colCount - 1], "X" => [$colCount - 1, $rowCount - 1]];

    foreach (["O", "X"] as $player) {
        foreach ($boardLines as $r => $row) {
            foreach (str_split($row) as $c => $ch) {
                if ($ch == $player) {
                    $playerPoints[$player][] = ($player == "O") ? [$r, $c] : [$c, $r];
                }
            }
        }
    }

    foreach ($playerPoints as $player => $points) {
        $targets = array_filter(range(0, $targetPoints[$player][1]), fn(int $c): bool => in_array([$targetPoints[$player][0], $c], $points));
        $targets = array_map(fn(int $c): array => [$targetPoints[$player][0], $c], $targets);
        foreach (array_filter(range(0, $targetPoints[$player][1]), fn(int $c): bool => in_array([0, $c], $points)) as $c) {
            $currentPath = [];
            if (_hasWinningPath($points, [0, $c], $targets, $currentPath)) {
                return ($player == "O") ? "white" : "black";
            }
        }
    }

    return "";
}

function _hasWinningPath(array $points, array $current, array $targets, array &$visitedPath): bool
{
    if (in_array($current, $targets)) {
        return true;
    }

    foreach ([[-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0]] as $step) {
        $next = [$current[0] + $step[0], $current[1] + $step[1]];
        if (in_array($next, $points) && !in_array($next, $visitedPath)) {
            $visitedPath[] = $next;
            if (_hasWinningPath($points, $next, $targets, $visitedPath)) {
                return true;
            }
            array_pop($visitedPath);
        }
    }

    return false;
}
