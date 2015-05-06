load('Data.mat')

m = size(Input,1);
n = size(Input,2);

%% a)
k = 2;
[train,test] = genkFoldIndex(k,n);

for K = 1:k
    % Try every p1
    for p1 = 1:6
        a_xy = linReg(Input(:,train{K}),Output(1:2,train{K}),p1);
        err_xy(K,p1) = getPosErr(a_xy,Input(:,test{K}),Output(1:2,test{K}));
    end
    % Try every p2
    for p2 = 1:6
        a_t = linReg(Input(:,train{K}),Output(3,train{K}),p2);
        err_t(K,p2) = getOrientErr(a_t,Input(:,test{K}),Output(3,test{K}));
    end
end

% Mean Position Err of all K folds
mean_err_xy = mean(err_xy);
% Best p1 which deliveres the smallest error
[min_err_xy,best_p1] = min(mean_err_xy);

% Mean Orientation Err of all K folds
mean_err_t = mean(err_t);
% Best p1 which deliveres the smallest error
[min_err_t,best_p2] = min(mean_err_t);

a_xy = linReg(Input,Output(1:2,:),best_p1);
a_t  = linReg(Input,Output(3,:),best_p2);

%% b)
k = 5;
[train,test] = genkFoldIndex(k,n);

for K = 1:k
    % Try every p1
    for p1 = 1:6
        a_xy = linReg(Input(:,train{K}),Output(1:2,train{K}),p1);
        err_xy(K,p1) = getPosErr(a_xy,Input(:,test{K}),Output(1:2,test{K}));
    end
    % Try every p2
    for p2 = 1:6
        a_t = linReg(Input(:,train{K}),Output(3,train{K}),p2);
        err_t(K,p2) = getOrientErr(a_t,Input(:,test{K}),Output(3,test{K}));
    end
end

% Mean Position Err of all K folds
mean_err_xy = mean(err_xy);
% Best p1 which deliveres the smallest error
[min_err_xy,best_p1] = min(mean_err_xy);

% Mean Orientation Err of all K folds
mean_err_t = mean(err_t);
% Best p1 which deliveres the smallest error
[min_err_t,best_p2] = min(mean_err_t);

a_xy = linReg(Input,Output(1:2,:),best_p1);
a_t  = linReg(Input,Output(3,:),best_p2);

par{1} = a_xy(:,1);
par{2} = a_xy(:,2);
par{3} = a_t;

save('params','par');