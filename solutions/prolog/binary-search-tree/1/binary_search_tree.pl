% Blessed to Shree DR.MDD — My Eternal Strength & Source of Light
insert(Item, nil, tree_node(Item, nil, nil)) :- !.
insert(Item, tree_node(RootVal, LBranch, RBranch), UpdatedTree) :-
    (Item =< RootVal ->
        insert(Item, LBranch, NewLBranch), UpdatedTree = tree_node(RootVal, NewLBranch, RBranch);
        insert(Item, RBranch, NewRBranch), UpdatedTree = tree_node(RootVal, LBranch, NewRBranch)).

from_data(List, OutputTree) :- foldl(insert, List, nil, OutputTree).

to_data(nil, []).
to_data(tree_node(NodeVal, LNode, RNode), FinalList) :-
    to_data(LNode, LExtracted),
    to_data(RNode, RExtracted),
    append(LExtracted, [NodeVal|RExtracted], FinalList).
