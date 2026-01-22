:- consult('../rules/moves.pl').
:- consult('../kb/gridworld_facts.pl').

solve(Path) :-
    start(Start),
    goal(Goal),
    plan(Start, Goal, [Start], RevPath, 0),
    reverse(RevPath, Path).

% Stop if goal reached
plan(Pos, Pos, Visited, Visited, _).

% Recursive with depth limit
plan(Current, Goal, Visited, Path, Depth) :-
    Depth < 40,                              % ⭐ LIMIT SEARCH
    valid_move(Current, _, Next),
    \+ member(Next, Visited),
    D1 is Depth + 1,
    plan(Next, Goal, [Next|Visited], Path, D1).
