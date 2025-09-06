unit module Sublist;

sub compare-lists ( @a, @b ) is export {
    return "equal"     if @a eqv @b;
    return "superlist" if not @b or @b eqv any @a.rotor(+@b => 1 - @b);
    return "sublist"   if not @a or @a eqv any @b.rotor(+@a => 1 - @a);
    return "unequal";
}