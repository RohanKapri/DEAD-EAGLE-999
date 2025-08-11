pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: u64 = 0,

        pub fn push(self: *Self, node: *Node) void {
            if (self.last) |last| {
                node.prev = last;
                last.next = node;
                self.last = node;
            } else {
                self.first = node;
                self.last = node;
            }

            self.len += 1;
        }

        pub fn pop(self: *Self) ?*Node {
            if (self.last == null) return null;
                
            var popped = self.last.?;
            self.last = popped.prev;
            if (self.last == null) {
                self.first = null;
            }
            popped.prev = null;

            self.len -= 1;
            return popped;
        }

        pub fn shift(self: *Self) ?*Node {
            if (self.first == null) return null;
            
            var shifted = self.first.?;
            self.first = shifted.next;
            if (self.first == null) {
                self.last = null;
            }
            shifted.next = null;

            self.len -= 1;
            return shifted;
        }

        pub fn unshift(self: *Self, node: *Node) void {
            if (self.first) |first| {
                node.next = first;
                first.prev = node;
                self.first = node;
            } else {
                self.first = node;
                self.last = node;
            }

            self.len += 1;
        }

        pub fn delete(self: *Self, node: *Node) void {
            var curr = self.first;

            while (curr) |c| : (curr = c.next) {
                if (c == node) {
                    if (c.prev == null) {
                        self.first = c.next;
                    } else if (c.next == null) {
                        self.last = c.prev;
                    } else {
                        c.prev.?.next = c.next;
                        c.next.?.prev = c.prev;
                    }

                    self.len -= 1;
                    return;
                }
            }
        }
    };
}