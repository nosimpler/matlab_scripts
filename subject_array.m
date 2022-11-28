function [X_new, y_new] = subject_array(X,y,t, func)

n_trials = 200;
n_subjs = length(X);
n_t = length(t);
X_new = zeros(n_subjs, n_t, n_trials);
if func
    for i = 1:length(X)
        for trial = 1:size(X{i},2)
        X{i} = func(X{i})

for i = 1:n_subjs
    X_new(i, :, :) = X{i}';
    y_new(i,:) = y{i}';
end
end