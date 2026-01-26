:- consult('../src/rules/learned_decision').

pos_action((1,1), right).
pos_action((2,3), right).
pos_action((3,7), up).
pos_action((4,2), down).
pos_action((5,4), left).
pos_action((6,7), left).
pos_action((7,3), down).

neg_action((0,0), left).
neg_action((5,4), down).
neg_action((4,3), right).
neg_action((1,1), left).
neg_action((8,7), up).
neg_action((6,4), right).
neg_action((3,2), down).

run_pos :-
    forall(
        pos_action(Pos, Act),
        ( best_action(Pos, Act)
        -> format('OK positive ~w -> ~w~n',[Pos,Act])
        ;  format('FAIL positive ~w -> ~w~n',[Pos,Act])
        )
    ).

run_neg :-
    forall(
        neg_action(Pos, Act),
        ( best_action(Pos, Act)
        -> format('FAIL negative ~w -> ~w~n',[Pos,Act])
        ;  format('OK negative ~w not chosen at ~w~n',[Act,Pos])
        )
    ).

:- run_pos.
:- run_neg.
