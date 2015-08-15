function [newstate, reward]=SimulateRobot(state, action)

load('reward.mat');
load('delta.mat');

% get next state from state transition matrix
newstate = d(state,action);
% get reward for current state and choosen action
reward = rew(state,action);

end

