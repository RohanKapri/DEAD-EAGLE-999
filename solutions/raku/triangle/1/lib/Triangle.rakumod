sub is-triangle {
    (* + * ≥ *)(|sort @_) and 0 < all @_
}

sub is-equilateral is export {
    is-triangle @_ and 1 == unique @_
}

sub is-isosceles is export {
    is-triangle @_ and 2 >= unique @_
}

sub is-scalene is export {
    is-triangle @_ and 3 == unique @_
}