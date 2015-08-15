function [ MU, SIGMA, PI] = em4gmm(X,MU,SIGMA,PI)

[m,N] = size(X);
K = size(MU,2);
min_diff = 0.0001;

%% INIT
logLH_old = getLogLH(X,MU,SIGMA,PI);

while 1
    %% E-STEP

    % Responsibility p(wk|xi,theta)
    respo = zeros(K,N);
    
    for k = 1:K
        for i = 1:N
            % SUM( pi_j * N(x_i|mu_j,SIGMA_j)
            n = PI * getPdf(X(:,i),MU,SIGMA)';
            z = PI(k) * getPdf(X(:,i),MU(:,k),SIGMA{k});
            respo(k,i) = z/n;
        end
    end

    %% M-STEP
    % nk = SUM( p(wk|xi,theta) )
    nk = sum(respo,2);
    % mu_k = 1/nk * SUM( p(wk|xi,theta)*xi )
    MU = ((respo * X') ./ repmat(nk,1,m))';
    % s_k = 1/nk * SUM( p(wk|xi,theta) * (xi-mu_k) * (xi-mu_k)' )
    for k = 1:K
       SIGMA{k} = 1/nk(k) * (repmat(respo(k,:),m,1) .*...
           bsxfun(@minus,X,MU(:,k))) * bsxfun(@minus,X,MU(:,k))';
    end
    % pi_k = nk / N;
    PI = nk' / N;
    
    %% Evaluation
    logLH = getLogLH(X,MU,SIGMA,PI);
    
    %  Is still a change in the Likelyhood?
    if abs(logLH-logLH_old) < min_diff
        % NO -> Stop and return parameter
        break;
    else
        % YES -> Conitnue with new Likelyhood
        logLH_old = logLH;
    end

end

end

