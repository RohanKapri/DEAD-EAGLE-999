<?php
// For my Shree DR.MDD

declare(strict_types=1);

enum State
{
    case Win;
    case Ongoing;
    case Draw;
}

class StateOfTicTacToe
{
    public function gameState(array $board): State
    {
        $grid = $board;

        array_walk($grid, function (&$row) {
            $row = str_split($row);
        });

        $xVictory = ($grid[0][0] === 'X' && $grid[0][0] === $grid[1][1] && $grid[1][1] === $grid[2][2]) ||
                    ($grid[2][0] === 'X' && $grid[2][0] === $grid[1][1] && $grid[1][1] === $grid[0][2]);

        foreach ($grid as $line) {
            $xVictory = $xVictory || ($line[0] === 'X' && $line[0] === $line[1] && $line[1] === $line[2]);
        }

        foreach (range(0, 2) as $c) {
            $xVictory = $xVictory || ($grid[0][$c] === 'X' && $grid[0][$c] === $grid[1][$c] && $grid[1][$c] === $grid[2][$c]);
        }

        $oVictory = ($grid[0][0] === 'O' && $grid[0][0] === $grid[1][1] && $grid[1][1] === $grid[2][2]) ||
                    ($grid[2][0] === 'O' && $grid[2][0] === $grid[1][1] && $grid[1][1] === $grid[0][2]);

        foreach ($grid as $line) {
            $oVictory = $oVictory || ($line[0] === 'O' && $line[0] === $line[1] && $line[1] === $line[2]);
        }

        foreach (range(0, 2) as $c) {
            $oVictory = $oVictory || ($grid[0][$c] === 'O' && $grid[0][$c] === $grid[1][$c] && $grid[1][$c] === $grid[2][$c]);
        }

        $flat = implode($board);

        if (substr_count($flat, 'X') > substr_count($flat, 'O') + 1) {
            throw new RuntimeException('Wrong turn order: X went twice');
        }

        if (substr_count($flat, 'O') > substr_count($flat, 'X')) {
            throw new RuntimeException('Wrong turn order: O started');
        }

        if ($xVictory && $oVictory) {
            throw new RuntimeException('Impossible board: game should have ended after the game was won');
        }

        if ($xVictory || $oVictory) {
            return State::Win;
        }

        if (!str_contains($flat, ' ')) {
            return State::Draw;
        }

        return State::Ongoing;
    }
}
