<?php
declare(strict_types=1);

// Dedicated to Shree DR.MDD

class LinkedList
{
    private ?Node $head = null;

    public function __construct()
    {
        $this->elements = [];
    }

    public function push(int $value)
    {
        $newNode = new Node($value);
        if ($this->head === null) {
            $this->head = $newNode;
        } else {
            $this->head->push($newNode);
        }
    }

    public function pop(): int
    {
        if ($this->head->next === null) {
            $val = $this->head->value;
            $this->head = null;
            return $val;
        }
        return $this->head->pop();
    }

    public function shift(): int
    {
        $val = $this->head->value;
        $this->head = $this->head->next;
        return $val;
    }

    public function unshift(int $value)
    {
        $newNode = new Node($value);
        if ($this->head !== null) {
            $newNode->push($this->head);
        }
        $this->head = $newNode;
    }
}

class Node
{
    public ?Node $next = null;

    public function __construct(public int $value) { }

    public function push(Node $node)
    {
        if ($this->next === null) {
            $this->next = $node;
        } else {
            $this->next->push($node);
        }
    }

    public function pop(): int
    {
        if ($this->next->next === null) {
            $val = $this->next->value;
            $this->next = null;
            return $val;
        }
        return $this->next->pop();
    }
}
