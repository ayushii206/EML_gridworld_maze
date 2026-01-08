:- initialization(run).

run :-
    consult('src/kb/gridworld_facts.pl'),
    consult('src/kb/cells.pl'),
    consult('src/rules/moves.pl'),
    consult('src/rules/distance.pl'),
    consult('src/rules/candidate.pl'),
    consult('src/rules/decision.pl'),
    consult('src/explain/explain.pl'),
    consult('src/explain/verify.pl'),
    consult('examples/pos_examples.pl'),
    consult('examples/neg_examples.pl'),
    verify_all,
    halt.
