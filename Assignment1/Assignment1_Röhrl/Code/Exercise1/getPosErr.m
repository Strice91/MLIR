function [err] = getPosErr(a,I,O)

n = size(I,2);      % Number of Samples
order = (size(a,1)-1) / 3;

% Build X Matrix
X = ones(n,(1+3*order));
for p = 1:order
    X(:,2+3*(p-1)) = I(1,:).^p;
    X(:,3+3*(p-1)) = I(2,:).^p;
    X(:,4+3*(p-1)) = (I(1,:) .* I(2,:)).^p;
end

% Prediction
pred = X*a;

% Calculate Position Error
err_v = O - pred';
err = sum(sqrt(err_v(1,:).^2 + err_v(2,:).^2)) / size(err_v,2);

%err = sum(sqrt(err_v(:).^2)) / numel(err_v) * 2;
end

