function [a] = linReg(I,O,order)

m = size(I,1);      % Size of Sample Vector
n = size(I,2);      % Number of Samples

% Build X Matrix
X = ones(n,(1+3*order));
for p = 1:order
    X(:,2+3*(p-1)) = I(1,:).^p;
    X(:,3+3*(p-1)) = I(2,:).^p;
    X(:,4+3*(p-1)) = (I(1,:) .* I(2,:)).^p;
end

% Perform lin regression
a = (X' * X)^-1 * X' * O';

end

