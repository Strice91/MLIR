load('Data.mat')

m = size(Input,1);
n = size(Input,2);

x = Output(1,:);
y = Output(2,:);
t = Output(3,:);

%% a)
k = 2;
ind = genkFoldIndex(k,n);

for K = 1:k
    for p1 = 1:6
        [a_xy{K},pred] = linReg(Input(:,ind{K}),Output(1:2,ind{K}),p1);
        err_xy{K} = getPosErr(x(ind{K}),pred(1,ind{K}),...
                              y(ind{K}),pred(2,ind{K}));
    end
end
