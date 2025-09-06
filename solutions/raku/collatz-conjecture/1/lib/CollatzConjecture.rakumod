sub collatz-conjecture ($number where 1..*) is export {
    end $number, -> \n { n %% 2 ?? n div 2 !! 3×n + 1 }...1
}