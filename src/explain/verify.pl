verify_positive :-
    pos_action(Pos,Act),
    best_move(Pos,Act),
    format("OK positive ~w -> ~w~n",[Pos,Act]),
    fail.
verify_positive.

verify_negative :-
    neg_action(Pos,Bad),
    \+ best_move(Pos,Bad),
    format("OK negative ~w not chosen at ~w~n",[Bad,Pos]),
    fail.
verify_negative.

verify_path :-
    pos_path(Expected),
    start(S),
    solve(S,Path),
    Path = Expected,
    writeln("OK path verified").

verify_all :-
    verify_positive,
    verify_negative,
    verify_path.
