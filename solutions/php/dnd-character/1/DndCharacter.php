<?php
declare(strict_types=1);
class DndCharacter
{
    public int $strength = 11;
    public int $dexterity = 11;
    public int $constitution = 11;
    public int $intelligence = 11;
    public int $wisdom = 11;
    public int $charisma = 11;
    public int $hitpoints = 10;
    public static function modifier(int $initial): float {
        return floor(($initial - 10) / 2);
    }
    public static function ability(): int {
        return 11;
    }

    public static function generate(): DndCharacter {
        return new DndCharacter();
    }
}