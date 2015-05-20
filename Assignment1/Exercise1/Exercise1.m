function par = Exercise1(k)
close all;
load('Data.mat')

m = size(Input,1);  % Size of Sample Vector
n = size(Input,2);  % Number of Samples

% k from input
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

tot_err_xy = getPosErr(a_xy,Input,Output(1:2,:));
tot_err_t = getOrientErr(a_t,Input,Output(3,:));

par{1} = a_xy(:,1);
par{2} = a_xy(:,2);
par{3} = a_t;

disp(sprintf('k=%i',k));
disp('X,Y');
disp(a_xy);
disp('Teta');
disp(a_t);
disp(sprintf('best_p1=%i best_p2=%i',[best_p1,best_p2]));
disp(sprintf('tot_err_xy=%0.4f tot_err_t=%0.4f',[tot_err_xy,tot_err_t]));

%save('params','par');

% Simulate_robot(0,0.05);
% try
%     matlab2tikz('../tex/img/robotLR1.tikz');
% end
% Simulate_robot(1,0);
% try
%     matlab2tikz('../tex/img/robotLR2.tikz');
% end
% Simulate_robot(1,0.05);
% try
%     matlab2tikz('../tex/img/robotLR3.tikz');
% end
% Simulate_robot(-1,-0.05);
% try
%     matlab2tikz('../tex/img/robotLR4.tikz');
% end

end