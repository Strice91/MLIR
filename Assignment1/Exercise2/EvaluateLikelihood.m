function [ LikValues ] = EvaluateLikelihood(Image,mu,Sigma)

img = double(imread(Image));

H = size(img,1);
W = size(img,2);

rgb = reshape(img,[H*W,3])';
% mu = repmat(mu,1,size(rgb,2));
% 
% e = (Sigma \ (rgb-mu));

p = zeros(1,H*W);

S = Sigma^-1;
D = det(Sigma);
d = 3;

for i = 1:H*W
    e = -0.5 * (rgb(:,i)-mu)' * S * (rgb(:,i)-mu);
    p(i) = exp(e) / ( (2*pi)^(d/2) * D^0.5 );
end

LikValues = reshape(p,H,W);


end

