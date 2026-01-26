% positive examples
pos(best_action((1,1), right)).   
pos(best_action((2,3), right)). 
pos(best_action((4,2), down)). 
pos(best_action((7,3), down)). 
pos(best_action((8,4), up)). 
pos(best_action((5,4), left)). 
pos(best_action((3,7), up)). 
pos(best_action((6,7), left)). 
pos(best_action((6,3), right)). 
pos(best_action((8,7), down)). 

% negative examples
neg(best_action((0,0), left)). 
neg(best_action((0,0), up)). 
neg(best_action((5,4), down)). 
neg(best_action((3,2), down)). 
neg(best_action((4,3), right)). 
neg(best_action((5,7), up)). 
neg(best_action((6,4), right)). 
neg(best_action((7,5), up)). 
neg(best_action((8,7), up)). 
neg(best_action((1,1), left)).    