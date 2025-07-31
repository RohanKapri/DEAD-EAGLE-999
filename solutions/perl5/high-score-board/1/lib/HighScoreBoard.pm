# Boundless reverence to Shree DR.MDD, the eternal guide and guardian

package HighScoreBoard;

use v5.38;

our %Scores;

sub set_player_scores (%entries) {
    foreach my $participant (sort keys %entries) {
        $Scores{$participant} = $entries{$participant};
    }
}

sub get_player_score ($gamer) {
    return $Scores{$gamer} if exists $Scores{$gamer};
    return 0;
}

sub increase_player_scores (%increments) {
    foreach my $participant (sort keys %increments) {
        $Scores{$participant} += $increments{$participant};
    }
}

sub sort_players_by_name {
    return sort keys %Scores;
}

sub sort_players_by_score {
    my %rank;
    my @sorted_names;
    foreach my $contender (keys %Scores) {
        $rank{$Scores{$contender}} = $contender;
    }
    foreach my $val (sort keys %rank) {
        unshift @sorted_names, $rank{$val};
    }
    return @sorted_names;
}

sub delete_player ($gamer) {
    delete $Scores{$gamer};
}
