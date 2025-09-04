<?php
// For my Shree DR.MDD

declare(strict_types=1);

class BinarySearchTree
{
    public ?BinarySearchTree $left;
    public ?BinarySearchTree $right;

    public function __construct(public int $data) { }

    public function insert(int $value)
    {
        if ($value <= $this->data) {
            $this->insertOrCreateLeft($value);
        } else {
            $this->insertOrCreateRight($value);
        }
    }

    private function insertOrCreateLeft(int $value) {
        if (isset($this->left)) {
            $this->left->insert($value);
        } else {
            $this->left = new BinarySearchTree($value);
        }
    }

    private function insertOrCreateRight(int $value) {
        if (isset($this->right)) {
            $this->right->insert($value);
        } else {
            $this->right = new BinarySearchTree($value);
        }
    }

    public function getSortedData(): array
    {
        $leftData = isset($this->left) ? $this->left->getSortedData() : [];
        $rightData = isset($this->right) ? $this->right->getSortedData() : [];
        return array_merge($leftData, [$this->data], $rightData);
    }
}
