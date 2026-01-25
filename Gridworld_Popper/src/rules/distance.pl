:- consult('../kb/gridworld_facts.pl').

distance((X,Y), D) :-
    goal((GX,GY)),
    D is abs(GX-X) + abs(GY-Y).
