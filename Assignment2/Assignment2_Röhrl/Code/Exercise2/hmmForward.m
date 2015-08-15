function [ p, a ] = hmmForward(B,A,Binned,PI)

N = size(A,1);
M = size(B,1);
[Q,T] = size(Binned);

% p(O|Lambda)
p = zeros(Q,1); 

for q = 1:Q
    % Init
    a = zeros(N,T);
    % alpha_1(i) = pi(i) * bi(o_1)
    a(:,1) = PI .* B(Binned(q,1),:);    
    % iterate thorugh a to fill all a
    % alpha_t+1(j) = SUM( Aij * alpha_t(i) ) * bj(o_t+1) 
    for t = 1:(T-1)
        a(:,t+1) = a(:,t)' * A .* B(Binned(q,t+1),:);
    end
    % p(O|Lambda) = SUM( a_T(i) )
    p(q) = sum(a(:,T));
end

end

