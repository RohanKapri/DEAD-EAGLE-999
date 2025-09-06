unit module Transpose;

sub transpose ($text) is export {
    my $len = max $text.lines».chars;
    roundrobin($text.lines.map: { .comb[^$len] »//» "\0" })
        .map({ .join.subst(/\0+$/).trans: "\0" => " " })
        .join: "\n"
}