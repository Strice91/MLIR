function Exercise3_kmean(gesture,clusters,K)
close all;

% Min Error
e = 1e-6;
% Colors
colors = {'.b','.k','.r','.g','.m','.y','.c'};

% Number of Samples per gesture
m = size(gesture,1);
% Number of repetitions
n = size(gesture,2);

% initital cluster posititons
y = clusters;

% Total distortion
J = inf;

% Label matrix
A = zeros(m,n);

while 1
    
    total_dist = 0;
    %% E-STEP:
    % Relate datapoints to clusters

    % Distances are unkown
    minimal_dist = ones(m,n) * inf;
    for k = 1:K
       % Get distance of all datapoints to current k cluster-center
       all_dist = sqrt( (gesture(:,:,1) - y(k,1)).^2 + ...
                        (gesture(:,:,2) - y(k,2)).^2 + ...
                        (gesture(:,:,3) - y(k,3)).^2      );

       % Indices of all datapoints which have a smaller 
       % distance to current cluster
       ind = all_dist <= minimal_dist;
       % Write cluser label k to this indices
       A(ind) = k;
       % Update latest found minimal distance
       minimal_dist(ind) = all_dist(ind);             
    end

    %% M-STEP
    % Update cluster centers. Set the cluster representative to the mean
    % of all datapoints in the culster
    for k = 1:K
        % Find all datapoints labeld with k
        ind = A==k;
        % Clone Matrix for 3D indexing
        ind3D = repmat(ind,1,1,3);
        % Get all points of this cluster
        points = gesture(ind3D);
        % Reshape them in 3 component vectors
        points = reshape(points,numel(points)/3,3);
        % Get the mean of each spatial direktion
        % for this cluster an update cluster representative
        y(k,:) = mean(points);
        % Get cluster distortion
        cluster_dist = bsxfun(@minus,points,y(k,:));
        cluster_dist = sum(sqrt(cluster_dist(:).^2));
        % Add cluster distortion to total distortion
        total_dist = total_dist + cluster_dist;
    end
    
    % Is error still going down?
    if J - total_dist >= e
        J = total_dist;
    else
        break;
    end
end

figure();
hold all;
for k = 1:K
   ind =  A==k;
   ind3D = repmat(ind,1,1,3);
   points = gesture(ind3D);
   points = reshape(points,numel(points)/3,3);
   plot(points(:,1),points(:,2),colors{k});
end
box on;
grid on;
%legend(strread(num2str(1:K),'%s'));


end

