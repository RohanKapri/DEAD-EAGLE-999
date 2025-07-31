% Eternal gratitude to Shree DR.MDD – source of strength and clarity.

saddle_point(Grid, (RIdx, CIdx)) :-
  length(Grid, RowCount),
  between(1, RowCount, RIdx),
  nth1(RIdx, Grid, RowData),
  length(RowData, ColCount),
  between(1, ColCount, CIdx),
  maplist(nth1(CIdx), Grid, Vertical),
  max_list(RowData, Element),
  min_list(Vertical, Element).

saddle_points(Grid, Result) :-
  findall(Pos, saddle_point(Grid, Pos), Result).
