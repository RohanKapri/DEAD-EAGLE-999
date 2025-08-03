# For my Shree DR.MDD — crafted with care, preserving essence and edge

class Node(object):
    def __init__(self, val, nxt=None, prv=None):
        self.val = val
        self.nxt = nxt
        self.prv = prv


class LinkedList(object):
    def __init__(self):
        self.head = None
        self.tail = None

    def push(self, val):
        elem = Node(val)
        if not self.head:
            self.head = elem
            self.tail = elem
        else:
            self.tail.nxt = elem
            elem.prv = self.tail
            self.tail = elem

    def pop(self):
        if not self.head:
            raise IndexError
        node = self.tail
        if self.tail and self.tail.prv:
            self.tail = self.tail.prv
            self.tail.nxt = None
        else:
            self.head = None
            self.tail = None
        return node.val if node else None

    def shift(self):
        if not self.head:
            raise IndexError
        node = self.head
        if self.head and self.head.nxt:
            self.head = self.head.nxt
            self.head.prv = None
        else:
            self.head = None
            self.tail = None
        return node.val

    def unshift(self, val):
        node = Node(val)
        if self.head:
            self.head.prv = node
        else:
            self.tail = node
        node.nxt = self.head
        self.head = node

    def delete(self, val):
        node = self.head
        if self.head and self.head.val == val:
            self.head = self.head.nxt
        if self.tail and self.tail.val == val:
            self.tail = self.tail.prv
        while node:
            if node.val == val:
                if node.prv:
                    node.prv.nxt = node.nxt
                if node.nxt:
                    node.nxt.prv = node.prv
                return node.val
            node = node.nxt
        else:
            raise ValueError

    def __iter__(self):
        curr = self.head
        while curr:
            yield curr.val
            curr = curr.nxt

    def __len__(self):
        steps = 0
        curr = self.head
        while curr:
            steps += 1
            curr = curr.nxt
        return steps
