function Exercise3_kmean(gesture,clusters,K)

% Min Error
e = 1e-6;
% Colors
colors = {'b','k','r','g','m','y','c'};

% Number of Samples per gesture
m = size(gesture,1);
% Number of repetitions
n = size(gesture,2);

% initital cluster posititons
y = clusters;

% adjacency matrix
A = zeros(m,n);

minimal_dist = ones(m,n) * inf;

for k = 1:K
   % Get distance of all Datapoints to current cluster center
   all_dist = sqrt( (gesture(:,:,1)-y(k,1)).^2 +...
                    (gesture(:,:,2)-y(k,2)).^2 +...
                    (gesture(:,:,3)-y(k,3)).^2      );
   % Indices of all Datapoints which have a smaller  
   ind = all_dist <= minimal_dist;
   A(ind) = k;
   minimal_dist(ind) = all_dist(ind);
                
end



end

