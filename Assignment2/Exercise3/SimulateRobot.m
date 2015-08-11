function [ new_s, new_rew ] = SimulateRobot(s, a)

load('reward.mat');
load('delta.mat');

% get next state from state transition matrix
new_s = d(s,a);
% get reward for current state and choosen action
new_rew = rew(s,a);

end

