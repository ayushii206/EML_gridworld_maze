inside_grid((X,Y)) :-
    grid_size(W,H),
    X >= 0, Y >= 0,
    X < W, Y < H.

free(Pos) :-
    inside_grid(Pos),
    \+ obstacle(Pos).
