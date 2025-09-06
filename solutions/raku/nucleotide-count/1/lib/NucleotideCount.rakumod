grammar DNA {
    token TOP   { <chain> *   }
    token chain { < A C G T > }
}
class DNA::Tally {
    method TOP ( $/ ) {
        make bag map *.Str, $<chain>
    }
}
sub nucleotide-count ( $strand ) is export {
    DNA.parse( $strand, actions => DNA::Tally )
       .made
    orelse fail 'Invalid nucleotide in strand'
}