:- consult(decision).
:- consult(distance).

explain_action(Pos, Action, Explanation) :-
    distance(Pos, D1),
    best_action(Pos, Action),
    valid_move(Pos, Action, NewPos),
    distance(NewPos, D2),
    Explanation = [
        from_distance(D1),
        to_distance(D2),
        reason('reduces distance to goal')
    ].
