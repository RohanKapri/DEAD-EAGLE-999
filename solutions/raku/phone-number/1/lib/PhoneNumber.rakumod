sub clean-number ($_) is export {
    die 'letters not permitted' if /<:Letter>/;
    die 'punctuations not permitted' if /<-[ 0..9 \- ( ) . + \s ]>/;
    my @digits = m:g/\d/;
    die 'must not be fewer than 10 digits' if @digits < 10;
    die 'must not be greater than 11 digits' if @digits > 11;
    if @digits == 11 {
        die '11 digits must start with 1' unless @digits[0] == 1;
        @digits.=skip;
    }
    die 'area code cannot start with zero' if @digits[0] == 0;
    die 'area code cannot start with one' if @digits[0] == 1;
    die 'exchange code cannot start with zero' if @digits[3] == 0;
    die 'exchange code cannot start with one' if @digits[3] == 1;
    @digits.join
}