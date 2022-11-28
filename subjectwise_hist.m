function [hist_subj, edges] = subjectwise_hist(func, X)
edges = linspace(0,1,50)
X_new = apply_to_all_trials(func, X)
n_subjs = length(X_new)
hist_subj = zeros(length(edges)-1, n_subjs)
for i = 1:length(X_new)
    X_subjs{i} = func(X{i})
    [hist_subj(:,i), edges] = histcounts(X_subjs{i}, edges)
end
edges = edges(2:end)
end
