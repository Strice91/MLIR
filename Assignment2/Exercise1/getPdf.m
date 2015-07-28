function [ pdf ] = getPdf(x, MU, SIGMA)

m = size(x,1);
k = size(SIGMA,2);

pdf = zeros(1,k);
% Get PDF for all k Gaussians
if iscell(SIGMA)
    % Multible Gaussians
    for i = 1:k
        pdf(i) = (1/((2*pi)^(m/2) * det(SIGMA{i})^0.5)) * ...
                exp( -0.5 * (x-MU(:,i))' * (SIGMA{i}\(x - MU(:,i))));
    end
else
    % Single Gaussian
    pdf = (1/((2*pi)^(m/2) * det(SIGMA)^0.5)) * ...
            exp( -0.5 * (x-MU)' * (SIGMA\(x - MU)));
end

end

