best_move(Pos, Act) :-
    findall(D-Action, candidate(Pos,Action,_,D), L),
    keysort(L, [_-Act|_]).

solve(Pos, []) :-
    goal(Pos).

solve(Pos, [A|R]) :-
    best_move(Pos, A),
    move(Pos, A, New),
    solve(New, R).
