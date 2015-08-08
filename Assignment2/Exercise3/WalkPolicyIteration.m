function [ output_args ] = WalkPolicyIteration( s )

load('delta.mat');
load('reward.mat');

% n = # states
% m = # actions
[n, m] = size(rew);

% Random init policy
policy = ceil(rand(n,1)*4);

% Discount Factor
y = 0.999;

policy_old = policy;

while 1
    I = eye(n);
    b = zeros(16,1);
    % For each state
    for j = 1:n
        b(j) = rew(j, policy(j));
        I(j, d(j,policy(j))) = -y;
    end
    vPi = I\b;
    
    for j = 1:n
        [~,policy(j)] = max(rew(j,:)' + y*vPi(d(j,:)));
    end
    
    if norm(policy-policy_old)<=0.1
        break;
    else
        policy_old = policy;
    end
end





end

