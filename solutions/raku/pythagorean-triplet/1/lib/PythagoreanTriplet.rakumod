unit module PythagoreanTriplet;
sub triplets-sum ($sum) is export {
    gather {
        for $sum div 2 - 1 ... floor(2.sqrt * $sum - $sum) + 1 -> $c {
            my $d = sqrt $c² - $sum² + 2 * $sum * $c;
            take ($sum - $c - $d) div 2, ($sum - $c + $d) div 2, $c if $d == $d.floor;
        }
    }
}