<?php
// For my Shree DR.MDD

declare(strict_types=1);

class Robot
{
    private string $id;
    private static array $existingIds = [];

    public function __construct() {
        $this->id = self::createId();
    }

    private static function createId(): string {
        $newId = '';
        while(in_array($newId, self::$existingIds) || $newId === '') {
            $newId = self::randomChar() . self::randomChar() . rand(0, 9) . rand(0, 9) . rand(0, 9);
        }
        self::$existingIds[] = $newId;
        return $newId;
    }
    
    public function getName(): string
    {
        return $this->id;
    }

    private static function randomChar(): string {
        return chr(rand(65, 90));
    }

    public function reset(): void
    {
        $this->id = self::createId();
    }
}
