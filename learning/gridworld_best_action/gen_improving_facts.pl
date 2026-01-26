:- consult('../../src/kb/gridworld_facts.pl').

inside_grid((X,Y)) :-
    grid_size(W,H),
    W1 is W - 1,
    H1 is H - 1,
    between(0, W1, X),
    between(0, H1, Y).

free_cell(Pos) :-
    inside_grid(Pos),
    \+ obstacle(Pos).

move((X,Y), right, (X1,Y)) :- X1 is X+1.
move((X,Y), left,  (X1,Y)) :- X1 is X-1.
move((X,Y), up,    (X,Y1)) :- Y1 is Y+1.
move((X,Y), down,  (X,Y1)) :- Y1 is Y-1.

valid_move(Pos, Action, NewPos) :-
    move(Pos, Action, NewPos),
    free_cell(NewPos).

distance((X,Y), D) :-
    goal((GX,GY)),
    D is abs(GX-X) + abs(GY-Y).

% improving_move: true if Act is a valid move that reduces Manhattan distance
improving_move((X,Y), Act) :-
    free_cell((X,Y)),
    valid_move((X,Y), Act, NewPos),
    distance((X,Y), D1),
    distance(NewPos, D2),
    D2 < D1.

% generate ground facts for ALL positions
write_improving_facts :-
    grid_size(W,H),
    W1 is W - 1,
    H1 is H - 1,
    forall(
        ( between(0, W1, X),
          between(0, H1, Y),
          improving_move((X,Y), Act)
        ),
        format('improving_move((~w,~w), ~w).~n', [X, Y, Act])
    ).
