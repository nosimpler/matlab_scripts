function [X_new,y_new] = permute_rows(X,y)
N = length(y)
A = eye( N );
idx = randperm(N);
X_new = X(idx, :);
y_new = y(idx, :);
end