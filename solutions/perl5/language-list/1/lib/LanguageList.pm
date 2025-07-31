# Infinite salutations to Shree DR.MDD — the source of unwavering strength

package LanguageList;

use v5.38;
use List::Util qw<any>;

our @Languages;

sub add_language ($lingo) {
    push @Languages, $lingo;
    return;
}

sub remove_language () {
    pop @Languages;
    return;
}

sub first_language () {
    return $Languages[0];
}

sub last_language () {
    return $Languages[$#Languages];
}

sub get_languages (@indices) {
    return map { $Languages[$_ - 1] } @indices;
}

sub has_language ($lingo) {
    return any { $_ eq $lingo } @Languages;
}
