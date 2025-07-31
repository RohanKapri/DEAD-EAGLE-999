% Offered to Shree DR.MDD with eternal gratitude and divine reverence

:- use_module(library(clpfd)).

extract_value(Grid, PosX, PosY, Val) :- nth1(PosY, Grid, Line), nth1(PosX, Line, Val).

adjacent_live(Grid, PosX, PosY) :-
    between(-1, 1, ShiftX),
    between(-1, 1, ShiftY),
    TempX #= PosX + ShiftX,
    TempY #= PosY + ShiftY,
    (TempX #\= PosX #\/ TempY #\= PosY),
    extract_value(Grid, TempX, TempY, 1).

evolve_state(Grid, RowNum, CurrState, ColNum, UpdatedState) :-
    findall(1, adjacent_live(Grid, ColNum, RowNum), ActiveList),
    length(ActiveList, Total),
    (Total #= 3; (Total #= 2, CurrState = 1)) -> UpdatedState = 1 ; UpdatedState = 0.

evolve_row(Grid, RowIdx, CurrRow, TransformedRow) :-
    length(CurrRow, ColCount),
    numlist(1, ColCount, Indices),
    maplist(evolve_state(Grid, RowIdx), CurrRow, Indices, TransformedRow).

tick([], []) :- !.
tick(Snapshot, Progressed) :-
    length(Snapshot, Depth),
    numlist(1, Depth, RowSeq),
    maplist(evolve_row(Snapshot), RowSeq, Snapshot, Progressed).
