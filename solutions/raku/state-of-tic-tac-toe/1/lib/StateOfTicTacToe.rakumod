enum State is export <win draw ongoing invalid>;
sub state-of-tic-tac-toe (@board) of State is export {
    my $_ = join '_', @board;
    return State::invalid unless 0 <= m:g/X/ - m:g/O/ <= 1;
    my $xwin = ?m/XXX|X...X...X|X.._.X._..X|..X_.X._X../;
    my $owin = ?m/OOO|O...O...O|O.._.O._..O|..O_.O._O../;
    if $xwin and $owin   { State::invalid }
    elsif $xwin or $owin { State::win }
    elsif m/\s/          { State::ongoing }
    else                 { State::draw }
}