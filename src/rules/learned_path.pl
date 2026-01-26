
:- consult('learned_decision.pl').    
:- consult('moves.pl').               
:- consult('cells.pl').
:- consult('distance.pl').            
:- consult('../kb/gridworld_facts.pl').


ordered_action(Pos, Action) :-
    findall(D2-A,
        ( valid_move(Pos, A, NewPos),
          distance(NewPos, D2)
        ),
        Pairs),
    sort(Pairs, Sorted),
    member(_-Action, Sorted).

action_candidate(Pos, Action) :-
    best_action(Pos, Action).
action_candidate(Pos, Action) :-
    ordered_action(Pos, Action),
    \+ best_action(Pos, Action).  

learned_path(Start, Goal, Path) :-
    learned_path(Start, Goal, [Start], Path).

learned_path(Pos, Pos, _, []) :-
    goal(Pos).

learned_path(Pos, Goal, Visited, [Action|Rest]) :-
    action_candidate(Pos, Action),          
    valid_move(Pos, Action, NewPos),
    \+ member(NewPos, Visited),
    learned_path(NewPos, Goal, [NewPos|Visited], Rest).
