function f = plotGmm(X,IDX,MU,SIGMA)

c = {'r','g','b','c','m','y','k'};

x1 = -0.1:0.001:0.1;
x2 = -0.1:0.001:0.1;
[X1,X2] = meshgrid(x1,x2);
K = size(MU,2);

[m,N] = size(X);

for j = 1:5
    h(j) = exp(-(j-1));
end

f = figure;
hold all;
for i = 1:K
    F = mvnpdf([X1(:) X2(:)],MU(:,i)',SIGMA{i});
    F = reshape(F,length(x2),length(x1));
    contour(x1,x2,F,h,c{i});
    %plot(X(1,IDX == i),X(2,IDX == i),strcat(c{i},'.')); 
    plot(MU(1,i),MU(2,i),strcat(c{i},'s'),'MarkerSize',10);
end

for j = 1:N
    [~,ind] = max(getPdf(X(:,j),MU,SIGMA));
    plot(X(1,j),X(2,j),strcat(c{ind},'.'));
end




end

