
function [b,A_new] = factor_null(A, y)
b0 = regress(y(:,1), A);
b1 = regress(y(:,2), A);
b = [b0 b1];
nb = orth(b);

P = nb*nb';
A_new = A - A*P
end
