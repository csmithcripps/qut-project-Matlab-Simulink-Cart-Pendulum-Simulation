function [H] = intmatexpB(A,B,T,n)
%INTMATEXPB compute int(e_AT) with approximation of order n 
    H = 0;
    for i = 1:100
        H = H + matexp(A,T/100 * i,n)*T/100;
    end
    H = H*B;
end

