function [ logLH ] = getLogLH(X,MU,SIGMA,PI)

N = size(X,2);

logLH = 0;
for i = 1:N
    % p(x|mu,SIGMA,PI)
    p = PI * getPdf(X(:,i),MU,SIGMA)';
    % Log Likelyhood
    logLH = logLH + log(p);
end



end

