/* =========================================================
   Explainable Gridworld Agent with Visualization (ASCII)
   ========================================================= */

:- dynamic goal/1.
:- dynamic obstacle/1.

% -------------------- ANSI COLORS --------------------
% Enables colored visualization of grid cells.

ansi(reset, "\e[0m").
ansi(red, "\e[31m").
ansi(green, "\e[32m").
ansi(yellow, "\e[33m").
ansi(blue, "\e[34m").
ansi(cyan, "\e[36m").

color(Color, Text) :-
    ansi(Color, C),
    ansi(reset, R),
    format("~w~w~w", [C, Text, R]).

% -------------------- WORLD DEFINITION --------------------
% Initializes a fresh Gridworld with a random goal and random obstacles

grid_size(9, 9).
start((1,1)).

clear_world :-
    retractall(goal(_)),
    retractall(obstacle(_)).

random_goal :-
    grid_size(MaxX,MaxY),
    repeat,
    random_between(1,MaxX,X),
    random_between(1,MaxY,Y),
    (X,Y) \= (1,1),
    assert(goal((X,Y))), !.

random_obstacles(0).
random_obstacles(N) :-
    N > 0,
    grid_size(MaxX,MaxY),
    random_between(1,MaxX,X),
    random_between(1,MaxY,Y),
    Cell = (X,Y),
    \+ start(Cell),
    \+ goal(Cell),
    \+ obstacle(Cell),
    assert(obstacle(Cell)),
    N1 is N - 1,
    random_obstacles(N1).
random_obstacles(N) :-
    N > 0,
    random_obstacles(N).

init_world :-
    clear_world,
    random_goal,
    random_obstacles(10),
    goal(G),
    format("World initialized. Goal at ~w~n", [G]).

% -------------------- BASIC RULES --------------------
% Checks whether a coordinate lies within grid boundaries and if a cell is inside the grid and not an obstacle.

inside_grid(X,Y) :-
    grid_size(MaxX,MaxY),
    X >= 1, X =< MaxX,
    Y >= 1, Y =< MaxY.

free((X,Y)) :-
    inside_grid(X,Y),
    \+ obstacle((X,Y)).

% -------------------- MOVEMENT --------------------
% Defines the four possible actions (up, down, left, right) and the resulting position for each action.

move((X,Y), up,    (X,Y1)) :- Y1 is Y-1.
move((X,Y), down,  (X,Y1)) :- Y1 is Y+1.
move((X,Y), left,  (X1,Y)) :- X1 is X-1.
move((X,Y), right, (X1,Y)) :- X1 is X+1.

% -------------------- DISTANCE --------------------
% Computes Manhattan distance between a position and the goal.

distance_to_goal((X,Y), D) :-
    goal((GX,GY)),
    D is abs(X-GX) + abs(Y-GY).

% -------------------- LEGAL MOVE --------------------
% Determines whether an action is allowed

legal_move(Pos,Action,NewPos,Visited) :-
    move(Pos,Action,NewPos),
    free(NewPos),
    \+ member(NewPos,Visited).

% -------------------- BEST ACTION --------------------
% Evaluates all legal actions from the current position. 
% Also generates a natural-language explanation for why an action was selected and rejected

best_action(Pos,Visited,Action,NewPos,BestDist,Explain) :-
    findall(
        move_eval(A,P,D),
        ( legal_move(Pos,A,P,Visited),
          distance_to_goal(P,D)
        ),
        Moves),
    Moves \= [],
    sort(3, @=<, Moves, [move_eval(Action,NewPos,BestDist)|Rest]),
    build_explanations(Pos, move_eval(Action,NewPos,BestDist), Rest, Explain).

build_explanations(Pos, move_eval(A,P,D), Others, [Best|Rejects]) :-
    distance_to_goal(Pos,Cur),
    format(string(Best),
      "I choose ~w because distance decreases from ~w to ~w via ~w.",
      [A,Cur,D,P]),
    build_rejects(Others,Rejects).

build_rejects([],[]).
build_rejects([move_eval(A,P,D)|T],[S|R]) :-
    format(string(S),
      "I reject ~w because distance would be ~w at ~w.",
      [A,D,P]),
    build_rejects(T,R).

% -------------------- VISUALIZATION --------------------
% Renders the entire Gridworld as ASCII art with colors.

draw_world(Agent,Visited) :-
    nl,
    grid_size(W,H),
    forall(between(1,H,Y),
        ( forall(between(1,W,X),
            draw_cell((X,Y),Agent,Visited)),
          nl )).

draw_cell(Pos,Agent,Visited) :-
    ( Pos = Agent ->
        color(cyan," A ")
    ; start(Pos) ->
        color(blue," S ")
    ; goal(Pos) ->
        color(green," G ")
    ; obstacle(Pos) ->
        color(red," # ")
    ; member(Pos,Visited) ->
        color(yellow," * ")
    ; write(" · ")
    ).

% -------------------- SOLVER --------------------
% Main solver, Initializes the world and starts the agent

solve :-
    init_world,
    solve_current_world.

% Runs the agent on the currently defined world
solve_current_world :-
    start(S),
    distance_to_goal(S,D),
    solve_step(S,[S],D).

solve_step(Pos,Visited,0) :-
    draw_world(Pos,Visited),
    color(green,"Goal reached!\n"),
    !.

solve_step(Pos,Visited,_) :-
    draw_world(Pos,Visited),
    ( best_action(Pos,Visited,A,NewPos,_,Explain)
    -> format("Action: ~w~n", [A]),
       forall(member(E,Explain), writeln(E)),
       distance_to_goal(NewPos,D2),
       solve_step(NewPos,[NewPos|Visited],D2)
    ;  color(red,"Dead end reached.\n"), !
    ).

% -------------------- COUNTERFACTUALS --------------------

what_if_remove_obstacle(Cell) :-
    obstacle(Cell),
    retract(obstacle(Cell)),
    writeln("Counterfactual: obstacle removed."),
    solve_current_world,
    assert(obstacle(Cell)).

what_if_add_obstacle(Cell) :-
    free(Cell),
    assert(obstacle(Cell)),
    writeln("Counterfactual: obstacle added."),
    solve_current_world,
    retract(obstacle(Cell)).

what_if_change_goal(NewGoal) :-
    goal(Old),
    retract(goal(Old)),
    assert(goal(NewGoal)),
    writeln("Counterfactual: goal changed."),
    solve_current_world,
    retract(goal(NewGoal)),
    assert(goal(Old)).

what_if_start(NewStart) :-
    start(Old),
    retract(start(Old)),
    assert(start(NewStart)),
    writeln("Counterfactual: start changed."),
    solve_current_world,
    retract(start(NewStart)),
    assert(start(Old)).