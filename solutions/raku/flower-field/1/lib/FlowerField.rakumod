use v6.*;
sub mark-flowers ($_) is export {
    .return if .none;
    my @a[.elems; .head.chars] = .map: *.comb;
    (try @a[||$_] = @a[||$_] + 1)
        for (-1..1 X -1..1) XZ+ grep(*.value eq '*', pairs @a)».key;
    [@a.rotor(.head.chars)».join]
}