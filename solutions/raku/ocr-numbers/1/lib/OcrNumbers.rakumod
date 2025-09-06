constant numbers = qq:to/END/;
 _     _  _     _  _  _  _  _ 
| |  | _| _||_||_ |_   ||_||_|
|_|  ||_  _|  | _||_|  ||_| _|
END
sub ascii-to-digits($art) is export {
    my @lines = $art.lines>>.comb;
    my @numbers = [Z](numbers.lines>>.comb).rotor(3);
    die unless @lines %% 4 && @lines[0] %% 3;
    @lines.rotor(4).map({ [Z](.head(*-1)).rotor(3).map({ @numbers.first($_, :k) // '?' }).join }).join: ','
}