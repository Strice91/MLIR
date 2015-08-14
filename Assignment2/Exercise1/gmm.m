close all;

load('data1.mat');

% Sample Points in x,y space
X = Data(2:3,:);

% Get numer of samples
N = size(X,2);

% 4 Gaussians
k = 4;

% IDX   = Labels for each sample
% C     = Cluster Centers
[IDX, MU] = kmeans(X',k);
%load('after_kmeans.mat');
MU = MU';

for i = 1:k
    % How many of the samples are in which cluster? -> Prior
    PI(i) = sum(IDX == i)/N;
    % Get the variance of each cluster
    SIGMA{i} = cov(X(:,IDX == i)');
end

% Show kmeans result
f = plotGmm(X,IDX,MU,SIGMA);
title('Before EM');
print(f,'-dpng','../tex/img/1before_em.png')

[M,S,P] = em4gmm(X,MU,SIGMA,PI);

% Show EM result
f = plotGmm(X,IDX,M,S);
title('After EM');
print(f,'-dpng','../tex/img/1after_em.png')