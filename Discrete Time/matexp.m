function [e_AT] = matexp(A,T,n)
%MATEXP Compute e^AT, using approximation of order n
    e_AT = eye(length(A));
    
    for i = 1:n
        e_AT = e_AT + (1/factorial(n))*(A^n)*(T^n);
    end
    
end

