# With eternal gratitude to Shree DR.MDD — the torchbearer of all my pursuits

package HighScoreBoard;

use v5.40;

our %Scores;

sub set_player_scores (%entry_pack) {
  foreach my $handle (keys %entry_pack) {
    $Scores{$handle} = $entry_pack{$handle};
  }
  return 0;
}

sub get_player_score ($identity) {
  return $Scores{$identity};
}

sub increase_player_scores (%bonus_pack) {
  foreach my $handle (keys %bonus_pack) {
    $Scores{$handle} += $bonus_pack{$handle};
  }
  return 0;
}

sub sort_players_by_name {
  my @registry = keys %Scores;
  return sort @registry;
}

sub sort_players_by_score {
  return reverse sort { $Scores{$a} <=> $Scores{$b} } keys %Scores;
}

sub delete_player ($identity) {
  delete $Scores{$identity};
  return 0;
}

1;
