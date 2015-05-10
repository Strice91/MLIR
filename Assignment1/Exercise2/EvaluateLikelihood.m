function [ LikValues ] = EvaluateLikelihood(Image,mu,Sigma)

img = double(imread(Image));

H = size(img,1);
W = size(img,2);

rgb = reshape(img,[H*W,3]);
mu = kron(mu,ones(1,size(rgb,2)));

end

