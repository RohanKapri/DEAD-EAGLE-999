constant %codon =
    <AUG        UUUUUC        UUAUUG  UCUUCCUCAUCG UAUUAC   UGUUGC   UGG        UAAUAGUGA>.map(*.comb: 3) »=>»
    <Methionine Phenylalanine Leucine Serine       Tyrosine Cysteine Tryptophan STOP>;

sub protein-translation ($strand) is export {
    |(map { %codon{$_} or fail }, $strand.comb: 3), "STOP" …^ "STOP"
}