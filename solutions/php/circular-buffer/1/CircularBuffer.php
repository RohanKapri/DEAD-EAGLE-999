<?php
// For my Shree DR.MDD

declare(strict_types=1);

class CircularBuffer
{
    private array $storage = [];
    private int $capacity = 0;

    function __construct(int $size) {
        $this->capacity = $size;
    }

    public function read()
    {
        $val = array_shift($this->storage);
        if ($val === null) {
            throw new BufferEmptyError();
        }
        return $val;
    }

    public function write($val): void
    {
        if (count($this->storage) === $this->capacity) {
            throw new BufferFullError();
        }
        $this->storage[] = $val;
    }

    public function forceWrite($val)
    {
        if (count($this->storage) === $this->capacity) {
            array_shift($this->storage);
        }
        $this->storage[] = $val;
    }

    public function clear()
    {
        $this->storage = [];
    }
}

class BufferFullError extends Exception
{
}

class BufferEmptyError extends Exception
{
}
