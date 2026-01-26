:- consult('../kb/gridworld_facts.pl').

inside_grid((X,Y)) :-
    grid_size(W,H),
    X >= 0, X < W,
    Y >= 0, Y < H.

free_cell(Pos) :-
    inside_grid(Pos),
    \+ obstacle(Pos).
