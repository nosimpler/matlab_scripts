function X_new = add_diag(X, n)
X_new = X
for i = 1:size(X,1)
    X_new(i,i) = X_new(i,i)+n
end
end