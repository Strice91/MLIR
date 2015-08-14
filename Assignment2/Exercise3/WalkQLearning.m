function WalkQLearning(s)

close all;

load('delta.mat');
load('reward.mat');

% n = # states
% m = # actions
[n, m] = size(rew);

% Simulations
S = 8000;

% Q-Function
Q = zeros(n,m);

% Parameter
e = 0.1;    % epsilon
y = 0.5;    % gamma
a = 0.9;    % alpha

% Starting state
state = s;

for t = 1:S
    % Take greedy action with probability 1-e
    action = greedy_step(Q, state, e);
    % Perform the choosen action
    [state_new, r] = SimulateRobot(state,action);
    % Calculate Q Function
    Q(state, action) = Q(state, action) + a*(r + y*max(Q(state_new, :)) - Q(state, action));
    % Set the new state
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

f = walkshow(q);
%set(gcf,'PaperUnits','inches','PaperPosition',[0 0 5 1])
%print(f,'-dpng',sprintf('../tex/img/3walkshow%d.png',s),'-r300')

end

