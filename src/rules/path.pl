:- consult(decision).
:- consult('../kb/gridworld_facts.pl').

path(Pos, Pos, []) :-
    goal(Pos).

path(Pos, Goal, [Action | Rest]) :-
    best_action(Pos, Action),
    valid_move(Pos, Action, NewPos),
    path(NewPos, Goal, Rest).
