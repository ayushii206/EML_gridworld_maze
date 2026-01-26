:- consult(candidate).

best_action(Pos, BestAction) :-
    findall(D-Act, candidate_action(Pos, Act, D), List),
    sort(List, [_-BestAction | _]).
