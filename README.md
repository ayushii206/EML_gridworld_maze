# Rule-Based Navigation in a Gridworld using Prolog 

**Winter Semester 2025**

**Course: Explainable Machine Learning** 

---

## Overview

This project presents an explainable Gridworld navigation system in which the agent’s decision-making policy is learned automatically using Inductive Logic Programming (ILP).

Instead of manually defining navigation rules, the system employs the Popper ILP framework to induce a symbolic action-selection rule from examples and background knowledge.

The learned rule is subsequently integrated into a Prolog-based planner to generate paths from a start position to a goal position while avoiding obstacles.

---

## Problem Statement

Given a two-dimensional Gridworld environment, the agent must decide:
```
Which action should be taken at each position to move toward the goal?
```

The decision must satisfy the following constraints:

- movements must remain inside the grid
- obstacle cells must be avoided
- the action should move the agent closer to the goal

The objective is to learn this decision rule automatically, rather than encoding it manually.

---

## Gridworld Environment

- Grid size: 9 × 9
- Coordinates: (X, Y)
- Start position: (0, 0)
- Goal position: (3, 8)
- Obstacles: predefined static cells

Allowed actions:

- up
- down
- left
- right

Distance to the goal is measured using Manhattan distance.

--- 

## Learning Approach

### Inductive Logic Programming (ILP)

Inductive Logic Programming (ILP) learns logical rules from examples using background knowledge.

In this project, ILP is used to learn the predicate:
```
best_action(Position, Action)
```
which represents the agent’s navigation policy.

### Use of Popper

Popper is an ILP system that searches for Prolog hypotheses consistent with background knowledge, positive examples, negative examples, and hypothesis constraints (bias).

Popper produces human-readable logical programs, making it especially suitable for Explainable AI.

### Learning Inputs

The learning process consists of:

1. Background knowledge
- Grid layout
- Goal position
- Precomputed valid improving actions

2. Positive examples
- Actions that should be selected in certain states

3. Negative examples
- Actions that must not be selected

4. Bias constraints
- Restrict hypothesis size and allowed predicates to ensure interpretability

### Learned Hypothesis

After training, Popper learns the following rule:

```
best_action(Position, Action) :-
    improving_move(Position, Action).
```

This rule is automatically induced and not manually written.

It expresses that a correct action is one that reduces the Manhattan distance to the goal.

---


## Running the Project

### System Requirements

- SWI-Prolog (version ≥ 9)
- Python (for Popper)
- Popper ILP installed and accessible via:
```
popper-ilp
```

### Step 1: Generate Background facts

From the project root directory:

```
swipl -q -s learning/gridworld_best_action/gen_improving_facts.pl \
     -g write_improving_facts -t halt \
     > learning/gridworld_best_action/improving_facts.pl
```

This step computes all valid actions that improve distance to the goal and converts them into ground facts for learning.

### Step 2: Run Popper

```
popper-ilp learning/gridworld_best_action
```

Popper searches for a hypothesis and automatically produces the learned program.

Example output:
```
best_action(V0,V1):- improving_move(V0,V1)
```

The learned hypothesis is stored in:
```
learned/best_action.pl
```

### Step 3: Run the learned planner

```
swipl
```

Load the system:
```
?- consult('src/kb/gridworld_facts.pl').
?- consult('src/rules/learned_path.pl').
```

Query the learned path:
```
?- set_prolog_flag(answer_write_options, [max_depth(1000)]).
?- start(S), goal(G), learned_path(S, G, Path).
```

A valid navigation path from start to goal will be returned.

### Step 4: Run tests

```
swipl -q -s tests/run_tests.pl
```
This evaluates the learned rule against independent positive and negative test cases.

---

## Key Contributions

- Demonstrates true machine learning using ILP
- Avoids manually defined decision rules
- Integrates learning with logical planning
- Produces interpretable symbolic policies
- Aligns with Explainable AI principles

---

## 👥 Contributors:

- [Ayushi Arora](https://github.com/ayushii206)
- [Ayush Salunke](https://github.com/AyushSalunke)

## Acknowledgements:

- [Youssef Mahmoud Youssef](https://www.h-brs.de/de/inf/youssef-mahmoud-youssef)

- [Hochschule Bonn-Rhein-Sieg](https://www.h-brs.de/de)
