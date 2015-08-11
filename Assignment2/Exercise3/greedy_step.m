function [ action ] = greedy_step(Q, s, e)

[m,n] = size(Q);

if rand > e
    % make a non greedy decission with the probability of e
    action = randsample(n,1);
else
    % make a greedy decission with the probability 1-e
    [~,action] = max(Q(s,:));  
end

end

