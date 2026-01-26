% Knowledge base
:- consult('src/kb/gridworld_facts.pl').

% Core rules
:- consult('src/rules/cells.pl').
:- consult('src/rules/moves.pl').
:- consult('src/rules/distance.pl').

% Decision making
:- consult('src/rules/candidate.pl').
:- consult('src/rules/decision.pl').

% Explainability
:- consult('src/rules/explain.pl').

% Path finding
:- consult('src/rules/path.pl').
:- consult('src/rules/valid_path.pl').

% Examples
:- consult('examples/pos_examples.pl').
:- consult('examples/neg_examples.pl').
