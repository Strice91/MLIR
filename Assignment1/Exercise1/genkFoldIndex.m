function [ind] = genkFoldIndex(k,n)

ind = cell(1,k);

for K = 1:k
    ind{K} = 1+(K-1)*(n/k):K*(n/k);
end

end

