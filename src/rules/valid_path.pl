:- consult(moves).
:- consult('../kb/gridworld_facts.pl').

valid_path(Start, Goal, Path) :-
    valid_path(Start, Goal, [Start], Path).

valid_path(Pos, Pos, _, []) :-
    goal(Pos).

valid_path(Pos, Goal, Visited, [Action | Rest]) :-
    valid_move(Pos, Action, NewPos),
    \+ member(NewPos, Visited),
    valid_path(NewPos, Goal, [NewPos | Visited], Rest).
