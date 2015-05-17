function [train,test] = genkFoldIndex(k,n)

ind = 1:n;
train = cell(1,k);
test  = cell(1,k);

for K = 1:k
    test{K} = 1+(K-1)*(n/k):K*(n/k);
    train{K} = setdiff(ind,test{K});
end

end

