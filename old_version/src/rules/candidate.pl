:- consult(moves).
:- consult(distance).

candidate_action(Pos, Action, D) :-
    free_cell(Pos),
    valid_move(Pos, Action, NewPos),
    distance(NewPos, D).

