function [ output_args ] = WalkPolicyIteration( s )

load('delta.mat');
load('rtest.mat');

% n = # states
% m = # actions
[n, m] = size(rew);

% Random init policy
policy = ceil(rand(n,1)*4);

% Discount Factor
y = 0.999;

% Iteration Counter
cnt = 0;

policy_old = policy;

while 1
    % Increase Counter
    cnt = cnt + 1;
    I = eye(n);
    b = zeros(16,1);
    % For each state
    for j = 1:n
        b(j) = rew(j, policy(j));
        I(j, d(j,policy(j))) = -y;
    end
    % Solve system of equations
    vPi = I\b;
    
    for j = 1:n
        [~,policy(j)] = max(rew(j,:)' + y*vPi(d(j,:)));
    end
    
    if norm(policy-policy_old)<=0.01
        break;
    else
        policy_old = policy;
    end
end

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

load('qtest.mat')
q-qtest

disp(sprintf('Interations needed: %d',cnt));
% print cartoon
walkshow(q);

end

