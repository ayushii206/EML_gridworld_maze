# Rule-Based Navigation in a Gridworld using Prolog 
**Winter Semester 2025**
**Course: Explainable Machine Learning** 

---

## Overview

This project implements an explainable decision-making agent in a 9x9 Gridworld using pure logic programming in SWI-Prolog.

The system does NOT use machine learning, reinforcement learning, or training.
All decisions are derived from symbolic rules and verified using positive and negative examples, following principles of Explainable AI (XAI) and Inductive Logic Programming (ILP).

---

## Gridworld Description

Grid size: 9 x 9  
Coordinates: (X,Y) where (0,0) is bottom-left  

Start position: (1,1)  
Goal position: (8,7)  
Obstacles: Statically defined in the knowledge base

Allowed actions:
- up
- down
- left
- right

The agent always selects the action that:

- remain inside the grid
- avoid obstacle cells
- reduce Manhattan distance to the goal

---

## Project Structure

### Knowledge Base

1. gridworld_facts.pl: Defines grid size, start position, goal position, and obstacle locations.

### Navigation Rules

1. cells.pl: Validates grid boundaries and free cells.
2. moves.pl: Defines state transitions for actions.
3. distance.pl: Computes Manhattan distance to the goal.
4. candidate.pl: Generates all valid actions from a position.
5. decision.pl: Selects the best action based on minimum distance.
6. path.pl: Generates a greedy path from start to goal.
7. valid_path.pl: Generates any valid path using loop-safe search.
8. explain.pl: Produces human-readable explanations for action choices.

### Verification

1. pos_examples.pl: Defines actions that must be selected.
2. neg_examples.pl: Defines actions that must not be selected.
3. run_tests.pl: Automatically validates all examples.

### Random Gridworld

random_gridworld/gridworld.pl: This is a all content file to generate random obstacles and random goal positions along with a visualization element to see the path the agent takes. Moreover you can also provide counterfactual statements for the agent the path it takes or can take. 

---

## Explainability Example

The system explains its decisions by showing:
- current position
- chosen action
- distance before the move
- distance after the move

```
?- explain_action((1,1), Action, Explanation).
```

Example Output: 
```
Action = right,
Explanation = [
    from_distance(13),
    to_distance(12),
    reason('reduces distance to goal')
].
```

This demonstrates transparent and interpretable decision-making.

---

## Testing 

### Automated Testing

To run all positive and negative examples: 

```
swipl -q -s tests/run_tests.pl
```
Example output:
```
OK positive 6,4 -> right
FAIL positive 7,5 -> right
OK positive 8,5 -> up
```

### Manual Testing

```
swipl  
```
```
?- consult('src/kb/gridworld_facts.pl').
?- consult('src/rules/candidate.pl').
?- consult('src/rules/cells.pl').
?- consult('src/rules/decision.pl').
?- consult('src/rules/distance.pl').
?- consult('src/rules/explain.pl').
?- consult('src/rules/moves.pl').
?- consult('src/rules/path.pl').
?- consult('src/rules/valid_path.pl').
```

To generate and print the path from start to goal:

```
?- set_prolog_flag(answer_write_options, [max_depth(1000)]).
```

```
?- start(S), goal(G), path(S, G, Actions), writeln(Actions).
```

### Positive and Negative Example testing

To verify the correctness of the navigation logic, the project uses **positive and negative examples**.  
These examples define *expected agent behavior* and are used only for **verification**, not for learning or training.

1. Positive examples: examples/pos_examples.pl

Example: 
```
pos_action((5,3), up).
```
This means that when the agent is at position (5,3), the correct action should be up.

So during testing the code checks whether:

```
?- best_action((5,3), up).
```

If it returns *true*, the positive example passes.

2. Negative examples: examples/neg_examples.pl

Example: 
```
neg_action((6,3), up).
```
This means that when the agent is at position (6,3), the action up must not be selected.

So during testing the code checks whether:

```
?- best_action((6,3), up)
```

If it returns *false*, the negative example passes.

---

## How to run random gridworld:

Go to the `/random_gridworld` directory from the root directory. And use the following commands
```
swipl -s gridworld.pl
```
```
?- solve.
```
The agent will give a reason along with a visualization of every move it makes to reach the goal position. You can also use the following counterfactual questions to the agent like:
```
?- what_if_remove_obstacle((Cell)).
?- what_if_add_obstacle((Cell)).
?- what_if_change_goal((NewGoal)).
?- what_if_start((NewStart)).
```
The cells are defined as `(column, row)`

---

## Key Idea

This project demonstrates Explainable AI using symbolic reasoning.
Instead of learning from data, the system uses logic rules and verification through examples to make and explain decisions.

---

## 👥 Contributors:

- [Ayushi Arora](https://github.com/ayushii206)
- [Ayush Salunke](https://github.com/AyushSalunke)

## Acknowledgements:

- [Youssef Mahmoud Youssef](https://www.h-brs.de/de/inf/youssef-mahmoud-youssef)

- [Hochschule Bonn-Rhein-Sieg](https://www.h-brs.de/de)
