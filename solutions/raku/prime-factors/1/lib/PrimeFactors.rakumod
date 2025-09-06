unit module PrimeFactors;

sub factors ( $number is copy ) is export {
    gather {
        for 2..$number.sqrt {
            while $number %% $_ {
                .take;
                $number div= $_;
            }
        }
        take $number if $number > 1;
    }
}