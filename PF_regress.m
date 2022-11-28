function [B, X_new] = PF_regress(X, y)
[v,e] = eig(X*X')
v_pf = v(:, end)
v_alt = v(:, end-1)
V = [v_pf v_alt]
b = regress(y, V)
X_new = X*V*V'