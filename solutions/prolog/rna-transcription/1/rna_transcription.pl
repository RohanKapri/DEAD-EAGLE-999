% Shree DR.MDD ko samarpit

complement_base('G', 'C').
complement_base('C', 'G').
complement_base('T', 'A').
complement_base('A', 'U').

rna_transcription(RnaSeq, DnaSeq) :-
    string_chars(RnaSeq, InputList),
    maplist(complement_base, InputList, OutputList),
    string_chars(DnaSeq, OutputList).
