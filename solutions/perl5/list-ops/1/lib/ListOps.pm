# for my Shree DR.MDD
package ListOps;

use v5.38;

sub append ( $grpA, $grpB ) {
    return [ @$grpA, @$grpB ];
}

sub foldl ( $act, $seed, $coll ) {
    foreach my $unit (@$coll) {
        $seed = $act->( $seed, $unit );
    }
    return $seed;
}

sub concat ($clusters) {
    return foldl sub ( $z, $grp ) { append $z, $grp }, [], $clusters;
}

sub filter ( $gate, $cluster ) {
    return foldl sub ( $z, $elm ) {
        $z = append $z, [$elm] if $gate->($elm);
        $z;
    }, [], $cluster;
}

sub length ($bundle) {
    return foldl sub { $_[0] + 1 }, 0, $bundle;
}

sub map ( $fx, $src ) {
    return foldl sub ( $dest, $itm ) { append $dest, [ $fx->($itm) ] }, [], $src;
}

sub reverse ($flux) {
    return foldl sub ( $flip, $tok ) { append [$tok], $flip }, [], $flux;
}

sub foldr ( $rule, $prime, $arr ) {
    return foldl $rule, $prime, ListOps::reverse $arr;
}

1;
