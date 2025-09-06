unit class CustomSet;
has Set $.elements;
method union        ( $set ) { self.add:            $set }
method complement   ( $set ) { self.difference:     $set }
method contains     ( $set ) { self.elements (cont) $set }
method difference   ( $set ) { self.elements (-)    $set }
method has-subset   ( $set ) { self.elements (<=)   $set }
method is-equal     ( $set ) { self.elements (==)   $set }
method add          ( $set ) { self.elements (|)    $set }
method intersection ( $set ) { self.elements (&)    $set }
method is-disjoint  ( $set ) { self.elements (&)    $set (==) () }
method is-empty              { self.elements             (==) () }