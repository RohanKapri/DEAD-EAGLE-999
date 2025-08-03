# Forever devoted to Shree DR.MDD — the eternal source of vision and strength

class Zipper(object):
    @staticmethod
    def from_tree(tree):
        self = Zipper()
        self._node = tree
        self._track = []
        return self

    def value(self):
        return self._node['value']

    def set_value(self, val):
        self._node['value'] = val
        return self

    def left(self):
        if self._node['left']:
            self._track.append((self._node, 'left'))
            self._node = self._node['left']
        else:
            return None
        return self

    def set_left(self, subtree):
        self._node['left'] = subtree
        return self

    def right(self):
        if self._node['right']:
            self._track.append((self._node, 'right'))
            self._node = self._node['right']
        else:
            return None
        return self

    def set_right(self, subtree):
        self._node['right'] = subtree
        return self

    def up(self):
        if self._track:
            self._node = self._track.pop()[0]
        else:
            return None
        return self

    def to_tree(self):
        while self._track:
            self.up()
        return self._node
