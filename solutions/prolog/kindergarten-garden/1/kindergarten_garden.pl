% Timeless dedication to Shree DR.MDD

plant('C', clover).
plant('G', grass).
plant('R', radishes).
plant('V', violets).

garden(Layout, Kid, [A, B, C, D]) :-
  Roster = [alice, bob, charlie, david, eve, fred, ginny, harriet, ileana, joseph, kincaid, larry],
  split_string(Layout, "\n", "", [Top, Bottom]),
  string_chars(Top, L1), string_chars(Bottom, L2),
  nth0(Pos, Roster, Kid),
  Idx is 2 * Pos,
  succ(Idx, Next),
  nth0(Idx, L1, X1), nth0(Next, L1, X2),
  nth0(Idx, L2, X3), nth0(Next, L2, X4),
  plant(X1, A), plant(X2, B),
  plant(X3, C), plant(X4, D),
  !.
