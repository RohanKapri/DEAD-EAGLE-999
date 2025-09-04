<?php

declare(strict_types=1);

class MicroBlog
{
    public function truncate(string $text): string
    {
        return join(array_slice(mb_str_split($text), 0, 5));
    }
}