function WalkPolicyIteration( s )

close all;

load('delta.mat');
load('reward.mat');

% n = # states
% m = # actions
[n, m] = size(rew);

% Random init policy
policy = ceil(rand(n,1)*4);

% Discount Factor
y = 0.999;

% Minimal Change in policy
p_min = 1e-4;
change = 1;

% Iteration Counter
cnt = 0;

policy_old = policy;

while change > p_min
    % Increase Counter
    cnt = cnt + 1;
    I = eye(n);
    X = zeros(16,1);
    
    % For each state
    for j = 1:n
        % Parts of Bellman equation
        X(j) = rew(j, policy(j));
        I(j, d(j,policy(j))) = -y;
    end
    
    % Solve system of equations
    vPi = I\X;
    
    % arg max
    for j = 1:n
        [~, policy(j)] = max(rew(j,:)' + y*vPi(d(j,:)));
    end
    
    % Caculate change in policy
    change = norm(policy-policy_old);
    
    % Update policy
    policy_old = policy;
end

% state sequence
q = zeros(1,16);
% initial state
q(1) = s;

for i = 2:length(q)
    % current state
    current_state = q(i-1);
    % next state
    q(i) = d(current_state, policy(current_state));
end

% load('qtest.mat')
% q-qtest

fprintf('Interations needed: %d',cnt);
% print cartoon
f = walkshow(q);
%set(gcf,'PaperUnits','inches','PaperPosition',[0 0 5 1])
%print(f,'-dpng',sprintf('../tex/img/3walkshow%d.png',s),'-r300')

end

