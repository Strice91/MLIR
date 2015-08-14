function formatResults( X, before, after, precission, start_of_line, end_of_line)

if nargin < 5
    start_of_line = '';
    end_of_line = '';
end

if nargin < 6
    end_of_line = '';
end

if iscell(X)
    for x = 1:length(X)
        A = X{x};
        [m,n] = size(A);
        for i = 1:m  
            fprintf(start_of_line);
            for j = 1:n
                str = strcat(before,'%',precission,after);
                fprintf(sprintf(str,A(i,j)));
            end
            fprintf(strcat(end_of_line,'\n'));
        end
        fprintf('\n');
    end
else
    A = X;
    [m,n] = size(A);
    for i = 1:m  
        fprintf(start_of_line);
        for j = 1:n
            str = strcat(before,'%',precission,after);
            fprintf(sprintf(str,A(i,j)));
        end
        fprintf(strcat(end_of_line,'\n'));
    end
end

end

