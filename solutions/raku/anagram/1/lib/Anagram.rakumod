sub match-anagrams ( :$subject!, :@candidates! ) is export {
    @candidates.grep: {
        my @words = ($_, $subject)>>.fc;
        [ne] @words and [eqv] @words.map(*.comb.sort)
    }
}