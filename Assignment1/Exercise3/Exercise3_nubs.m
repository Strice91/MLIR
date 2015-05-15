function Exercise3_nubs(gesture,max_K)
close all;

% Colors
colors = {'.b','.k','.r','.g','.m','.y','.c'};

% Number of Samples per gesture
m = size(gesture,1);
% Number of repetitions
n = size(gesture,2);

r = gesture(:,:,1);
s = gesture(:,:,2);
t = gesture(:,:,3);

% initital cluster
y = zeros(max_K,3);
% first culster is mean of all points
y(1,:) = [mean2(gesture(:,:,1));mean2(gesture(:,:,2));mean2(gesture(:,:,3))];

% Label matrix
% All points belong to first cluster
A = ones(m,n);

K = 1;

while K < max_K
    
    J_max = 0;

    for k = 1:K
        % Find all datapoints labled with k
        ind = A==k;
        % Clone Matrix for 3D indexing
        ind3D = repmat(ind,1,1,3);
        % Get all points of this cluster
        points = gesture(ind3D);
        % Reshape them in 3 component vectors
        points = reshape(points,numel(points)/3,3);
        % Get cluster distortion
        cluster_dist = bsxfun(@minus,points,y(k,:));
        cluster_dist = sum(sqrt(cluster_dist(:).^2));

        % Is this cluster the one with the highest distortion?
        if cluster_dist > J_max
           % Update highest distortion
           J_max = cluster_dist;
           % remember cluster for splitting
           split_cluster = k;
        end
    end

    % random vector for split directions
    v = rand(1,3);

    % Add new vector for cluster Xb
    y(K+1,:) = y(split_cluster,:) + v;
    % Update old vector for cluster Xa
    y(split_cluster,:) = y(split_cluster,:) - v;

    % All points which where in the cluster to split
    split_ind = A==split_cluster;

    % Distances to representative Xa
    dist_Xa = sqrt( (r(split_ind) - y(split_cluster,1)).^2 + ...
                    (s(split_ind) - y(split_cluster,2)).^2 + ...
                    (t(split_ind) - y(split_cluster,3)).^2      );

    % Distances to representative Xb
    dist_Xb = sqrt( (r(split_ind) - y(K+1,1)).^2 + ...
                    (s(split_ind) - y(K+1,2)).^2 + ...
                    (t(split_ind) - y(K+1,3)).^2      );
    
    % Indices which are closer to Xa
    ind_Xa = dist_Xa <= dist_Xb;
    % Indices which are closer to Xb
    ind_Xb = dist_Xa > dist_Xb;

    % Update labels
    A(split_ind) = (ind_Xa) * split_cluster + (ind_Xb) * (K+1);

    ind = A==split_cluster;
    % Clone Xa Matrix for 3D indexing
    ind3D_Xa = repmat(ind,1,1,3);
    % Get all points of this cluster
    points_Xa = gesture(ind3D_Xa);
    % Reshape them in 3 component vectors
    points_Xa = reshape(points_Xa,numel(points_Xa)/3,3);
    % Get the mean of each spatial direktion
    % for this cluster an update cluster representative
    y(split_cluster,:) = mean(points_Xa);

    ind = A==K+1;
    % Clone Xb Matrix for 3D indexing
    ind3D_Xb = repmat(ind,1,1,3);
    % Get all points of this cluster
    points_Xb = gesture(ind3D_Xb);
    % Reshape them in 3 component vectors
    points_Xb = reshape(points_Xb,numel(points_Xb)/3,3);
    % Get the mean of each spatial direktion
    % for this cluster an update cluster representative
    y(K+1,:) = mean(points_Xb);

    % increase K for next interration
    K = K+1;
end

figure();
hold all;

for k = 1:K
   % Find all datapoints labled with k
   ind =  A==k;
   % Clone Matrix for 3D indexing
   ind3D = repmat(ind,1,1,3);
   % Get all points of this cluster
   points = gesture(ind3D);
   % Reshape them in 3 component vectors
   points = reshape(points,numel(points)/3,3);
   % plot x,y values of each cluster point
   plot(points(:,1),points(:,2),colors{k});
end
box on;
grid on;

end

