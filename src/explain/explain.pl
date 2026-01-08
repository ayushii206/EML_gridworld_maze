explain(Pos) :-
    best_move(Pos, Act),
    move(Pos, Act, New),
    goal(G),
    distance(Pos, G, D1),
    distance(New, G, D2),
    format("From ~w choose ~w because distance goes from ~w to ~w~n",
           [Pos, Act, D1, D2]).
