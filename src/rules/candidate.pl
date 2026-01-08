candidate(Pos, Act, NewPos, Dist) :-
    move(Pos, Act, NewPos),
    free(NewPos),
    goal(G),
    distance(NewPos, G, Dist).
