:- consult('../src/rules/explain').
:- consult('../examples/pos_examples').
:- consult('../examples/neg_examples').

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
