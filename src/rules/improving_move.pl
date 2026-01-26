:- consult(moves).
:- consult(distance).
:- consult(cells).

improving_move(Pos, Act) :-
    free_cell(Pos),          % <-- THIS LINE FIXES IT
    valid_move(Pos, Act, NewPos),
    distance(Pos, D1),
    distance(NewPos, D2),
    D2 < D1.
