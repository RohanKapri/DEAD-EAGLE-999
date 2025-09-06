# For my Junko F. Didi and Shree DR.MDD

unit class LinkedList;

class Node {
    has $.prev is rw = self;
    has $.next is rw = self;
    has $.value;

    method detach {
        $!prev.next = $!next;
        $!next.prev = $!prev;
        self
    }

    method attach {
        $!prev.next = self;
        $!next.prev = self;
        self
    }
}

has $!sentinel = Node.new(value => NaN);
has $.count = 0;    # public so tests can access it

method push ($val) {
    $!count++;
    Node.new(value => $val, prev => $!sentinel.prev, next => $!sentinel).attach
}

method pop {
    $!count--;
    $!sentinel.prev.detach.value
}

method shift {
    $!count--;
    $!sentinel.next.detach.value
}

method unshift ($val) {
    $!count++;
    Node.new(value => $val, prev => $!sentinel, next => $!sentinel.next).attach
}

method delete ($val) {
    my $node = $!sentinel.next;
    $node.=next until $node.value ⩶ NaN | $val;
    return unless $node.value == $val;
    $node.detach;
    $!count--
}
