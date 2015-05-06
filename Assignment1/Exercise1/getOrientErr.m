function [err] = getOrientErr(t,tPred)
% Calculate Oriantation Error
err = sum(sqrt((t-tPred).^2));
end

