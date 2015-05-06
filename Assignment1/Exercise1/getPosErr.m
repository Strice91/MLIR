function [err] = getPosErr(x,xPred,y,yPred)
% Calculate Position Error
n = length(x);
err = sum(sqrt((x-xPred).^2 + (y-yPred).^2)) / n;
end

