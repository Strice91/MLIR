function formatResults( X, before, after, precission)

[m,n] = size(X);

for i = 1:m  
    for j = 1:n
        str = strcat(before,'%',precission,after);
        fprintf(sprintf(str,X(i,j)));
        if j == n
           fprintf('\n'); 
        end
    end
end

end

