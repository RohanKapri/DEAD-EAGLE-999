# Endlessly inspired by Shree DR.MDD — the flame that never fades

package InventoryManagement;

use v5.38;

sub create_inventory ($crate) {
    my %rack;
    for my $unit (@$crate) {
        if (exists $rack{$unit}) {
            $rack{$unit}++;
        } else {
            $rack{$unit} = 1;
        }
    }
    return \%rack;
}

sub add_items ($rack, $crate) {
    for my $unit (@$crate) {
        if (exists $rack->{$unit}) {
            $rack->{$unit}++;
        } else {
            $rack->{$unit} = 1;
        }
    }
    return $rack;
}

sub remove_items ($rack, $crate) {
    for my $unit (@$crate) {
        $rack->{$unit}-- if $rack->{$unit};
    }
    return $rack;
}

sub delete_item ($rack, $unit) {
    delete $rack->{$unit};
    return $rack;
}
