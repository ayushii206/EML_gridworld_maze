:- consult('../src/rules/learned_decision').

pos_action((1,0), right).
pos_action((2,0), right).
pos_action((3,1), right).
pos_action((4,2), right).
pos_action((5,3), up).
pos_action((6,4), right).
pos_action((8,5), up).

neg_action((0,0), left).
neg_action((0,0), down).
neg_action((2,1), up).
neg_action((6,3), up).
neg_action((8,5), down).

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
