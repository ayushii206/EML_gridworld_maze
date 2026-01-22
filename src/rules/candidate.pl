:- consult(moves).
:- consult(distance).

candidate_action(Pos, Action, D) :-
    valid_move(Pos, Action, NewPos),
    distance(NewPos, D).
