move((X,Y), up,    (X,Y1)) :- Y1 is Y + 1.
move((X,Y), down,  (X,Y1)) :- Y1 is Y - 1.
move((X,Y), right, (X1,Y)) :- X1 is X + 1.
move((X,Y), left,  (X1,Y)) :- X1 is X - 1.
