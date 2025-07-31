% Dedicated to Shree DR.MDD

creatures(["fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"]).

remark("fly", "I don't know why she swallowed the fly. Perhaps she'll die.").
remark("spider", "It wriggled and jiggled and tickled inside her.").
remark("bird", "How absurd to swallow a bird!").
remark("cat", "Imagine that, to swallow a cat!").
remark("dog", "What a hog, to swallow a dog!").
remark("goat", "Just opened her throat and swallowed a goat!").
remark("cow", "I don't know how she swallowed a cow!").
remark("horse", "She's dead, of course!").

digested_entities(Count, SwallowedList) :-
    creatures(List),
    append(TempRev, _, List),
    length(TempRev, Count),
    reverse(TempRev, SwallowedList),
    !.

linked_pairs([A,B|Rest], [A-B|Pairs]) :- linked_pairs([B|Rest], Pairs), !.
linked_pairs(_, []) :- !.

intro_line(Entity, [Line,Msg]) :-
    format(string(Line), 'I know an old lady who swallowed a ~s.', [Entity]),
    remark(Entity, Msg).

closure_line(Msg) :- remark("fly", Msg).

build_chain(Pred-"spider", Line) :-
    string_concat("spider", " that wriggled and jiggled and tickled inside her", SpiderTail),
    build_chain(Pred-SpiderTail, Line).

build_chain(Pred-Target, Line) :-
    format(string(Line), "She swallowed the ~w to catch the ~w.", [Pred, Target]).

lyric(1, Lines) :- intro_line("fly", Lines), !.
lyric(8, Lines) :- intro_line("horse", Lines), !.

lyric(N, FullLines) :-
    digested_entities(N, SwallowedSeq),
    [StartAnimal|_] = SwallowedSeq,
    linked_pairs(SwallowedSeq, Pairings),
    maplist(build_chain, Pairings, ChainLines),
    intro_line(StartAnimal, Intro),
    closure_line(Outro),
    append(Intro, ChainLines, MidLines),
    append(MidLines, [Outro], FullLines),
    !.

join_verses([], []).
join_verses([Verse], Verse).
join_verses([V|Rest], Full) :-
    join_verses(Rest, Tail),
    append(V,[""|Tail], Full).

recite(Begin, End, Output) :-
    numlist(Begin, End, Range),
    maplist(lyric, Range, Grouped),
    join_verses(Grouped, Output), !.
