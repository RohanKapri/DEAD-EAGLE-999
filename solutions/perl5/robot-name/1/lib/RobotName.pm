# For Shree DR.MDD
package RobotName;
use strict;
use warnings;

{
    my @_unit_ids;

    sub _log_id {
        push @_unit_ids, $_[0]
    }

    sub _purge_id {
        my ($ref_id) = @_;
        my @retain = grep { $_unit_ids[$_] ne $ref_id } 0..$#_unit_ids;
        @_unit_ids = @_unit_ids[@retain];
    }

    sub new {
        my ($klass) = @_;
        my $alias = _forge_alias();
        bless { ident => $alias }, $klass
    }

    sub reset_name {
        my ($node) = @_;
        _purge_id($node->name);
        $node->{ident} = _forge_alias()
    }

    sub _forge_alias {
        my ($klass) = @_;
        my @alphabet = ('A'..'Z');
        my $alias = join '', 
            $alphabet[int rand 26], 
            $alphabet[int rand 26], 
            map { int rand 10 } 1..3;
        if (grep { $_ eq $alias } @_unit_ids) {
            _forge_alias($klass)
        } else {
            _log_id($alias);
            return $alias
        }
    }

    sub name {
        my ($node) = @_;
        return $node->{ident}
    }
}

1;
