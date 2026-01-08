# Rule-Based Navigation in a Gridworld using Prolog 
**Winter Semester 2025**  
**Prof. Youssef Mahmoud Youssef**  
**Course: Explainable Machine Learning** 

---

## Overview

This project implements an explainable decision-making agent in a 4x4 Gridworld using pure logic programming in SWI-Prolog.

The system does NOT use machine learning, reinforcement learning, or training.
All decisions are derived from symbolic rules and verified using positive and negative examples, following principles of Explainable AI (XAI) and Inductive Logic Programming (ILP).

---

## Gridworld Description

Grid size: 4 x 4  
Coordinates: (X,Y) where (0,0) is bottom-left  

Start position: (0,0)  
Goal position: (3,3)  
Obstacles: (1,1), (2,2)  

Allowed actions:
- up
- down
- left
- right

The agent always selects the action that reduces the Manhattan distance to the goal while avoiding obstacles and grid boundaries.

---

## File Explanation

1. gridworld_facts.pl: Defines grid size, start position, goal position, and obstacle locations.

2. cells.pl: Checks whether a cell is inside the grid and not an obstacle.

3. moves.pl: Defines how each action changes the agent’s position.

4. distance.pl: Computes Manhattan distance from a position to the goal.

5. candidate.pl: Generates all legal actions from a position and evaluates them.

6. decision.pl: Selects the best action and generates a path to the goal.

7. explain.pl: Explains why a particular action was chosen.

8. verify.pl: Verifies correctness using positive and negative examples.

9. pos_examples.pl: Contains correct (expected) actions and paths.

10. neg_examples.pl: Contains forbidden actions that must not be chosen.

11. run_tests.pl: Loads all files and runs automated verification tests.

---

## Explainability

The system explains its decisions by showing:
- current position
- chosen action
- distance before the move
- distance after the move

```
?- explain((0,0)).
```
---

## Testing Methods

### 1. Individual Positive Example Testing

Checks whether an expected correct action is chosen.

```
?- best_move((1,0), right).
```

Expected result:
```
true.
```

---

### 2. Individual Negative Example Testing

Checks whether a forbidden action is rejected.


```
?- best_move((0,0), left).
```

Expected result:
```
false.
```

---

### 3. Batch Verification Testing

Runs all positive and negative examples automatically.

```
swipl -q -s tests/run_tests.pl
```

Example output:
```
OK positive 1,0 -> right  
OK positive 2,0 -> up  
OK negative left not chosen at 0,0  
OK negative right not chosen at 1,1  
```

---

### 4. Path Verification

Checks whether the generated path matches the expected shortest path.

Query:
```
?- start(S), solve(S, Path).
```

The output path is compared against the expected path defined in pos_examples.pl.

---

### 5. Manual Verification

The generated path can be manually traced on the grid to verify:
- no obstacles are crossed
- all moves are legal
- the goal is reached
- distance to the goal decreases

---

## Extending the Project

The grid remains 4x4, but additional examples can be added:

- more positive action examples
- more negative action examples
- more explanation queries

No changes to the logic are required.

---

## How to Run the Project

From the project root directory:

```
swipl -q -s tests/run_tests.pl
```

To interact manually:

```
swipl  
```
```
?- consult('tests/run_tests.pl').
```

---

## Key Idea

This project demonstrates Explainable AI using symbolic reasoning.
Instead of learning from data, the system uses logic rules and verification through examples to make and explain decisions.

---

## Academic Relevance

This project demonstrates:
- Explainable AI
- Logic-based decision making
- Verification using positive and negative examples
- Transparent and human-interpretable reasoning

It fully aligns with the objectives of an Explainable Machine Learning course.

---

## 👥 Contributors:

- [Ayushi Arora](https://github.com/ayushii206)
- [Ayush Salunke](https://github.com/AyushSalunke)

## Acknowledgements:

- [Youssef Mahmoud Youssef](https://www.h-brs.de/de/inf/youssef-mahmoud-youssef)

- [Hochschule Bonn-Rhein-Sieg](https://www.h-brs.de/de)
