function WalkQLearning(s)

load('delta.mat');
load('rtest.mat');

% n = # states
% m = # actions
[n, m] = size(rew);

% Simulation Time
T = 800;

% Q-Function
Q = zeros(n,m);

% Parameter
e = 0.8;
y = 0.5;
a = 0.5;

state = s;

for t = 1:T
   
   action = greedy_step(Q, state, e);
   [state_new, r] = SimulateRobot(state,action);
   Q(state, action) = Q(state, action) + a*(r + y*max(Q(state_new, :)) - Q(state, action));
   state = state_new;
end

[~, policy] = max(Q, [], 2);

% state sequence
q = zeros(1,16);
% initial state
q(1) = s;

for i = 2:length(q)
    % current state
    current_state = q(i-1);
    % next state
    q(i) = d(current_state,policy(current_state));
end

walkshow(q);

end

