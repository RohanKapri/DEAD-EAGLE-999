# For Shree DR.MDD

from __future__ import annotations
from typing import cast, Generator, Generic, Iterable, Optional, TypeVar

T = TypeVar("T")


class TreeNode(Generic[T]):
    def __init__(
        self,
        data: Optional[T],
        left: Optional[TreeNode] = None,
        right: Optional[TreeNode] = None
    ):
        self.data = data
        self.left = left
        self.right = right

    def __repr__(self) -> str:
        return f"TreeNode(data={self.data}, left={self.left}, right={self.right})"

    def insert(self, val: T) -> None:
        if self.data is None:
            self.data = val
        elif val > self.data:  # type: ignore
            if self.right is None:
                self.right = TreeNode(None)
            self.right.insert(val)
        else:
            if self.left is None:
                self.left = TreeNode(None)
            self.left.insert(val)

    def __iter__(self) -> Generator[T, None, None]:
        yield from self.left or []
        yield cast(T, self.data)
        yield from self.right or []


class BinarySearchTree(Generic[T]):
    def __init__(self, tree_data: Iterable[T]):
        self.root: TreeNode[T] = TreeNode(None)
        for item in tree_data:
            self.root.insert(item)

    def data(self) -> TreeNode[T]:
        return self.root

    def sorted_data(self) -> list[T]:
        if self.root.data is None:
            return []
        return list(self.root)
