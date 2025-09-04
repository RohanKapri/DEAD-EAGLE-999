<?php
// For my Shree DR.MDD

declare(strict_types=1);

class RobotSimulator
{
    const RIGHT_TURN = [
        'north' => 'east',
        'east' => 'south',
        'south' => 'west',
        'west' => 'north'
    ];

    const LEFT_TURN = [
        'east' => 'north',
        'south' => 'east',
        'west' => 'south',
        'north' => 'west'
    ];

    const MOVE_MAP = [
        'north' => [0, 1],
        'east' => [1, 0],
        'south' => [0, -1],
        'west' => [-1, 0]
    ];

    private array $coordinates;
    private string $facing;

    /** @param int[] $position */
    public function __construct(array $position, string $direction)
    {
        $this->coordinates = $position;
        $this->facing = $direction;
    }

    public function instructions(string $commands): void
    {
        $commandsArr = str_split($commands);
        foreach ($commandsArr as $cmd) {
            if ($cmd === 'R') {
                $this->facing = self::RIGHT_TURN[$this->facing];
                continue;
            }
            if ($cmd === 'L') {
                $this->facing = self::LEFT_TURN[$this->facing];
                continue;
            }
            if ($cmd === 'A') {
                $this->coordinates = $this->moveForward();
            }
        }
    }

    /** @return int[] */
    public function getPosition(): array
    {
        return $this->coordinates;
    }

    public function getDirection(): string
    {
        return $this->facing;
    }

    private function moveForward(): array
    {
        $delta = self::MOVE_MAP[$this->facing];
        return [
            $this->coordinates[0] + $delta[0],
            $this->coordinates[1] + $delta[1]
        ];
    }
}
