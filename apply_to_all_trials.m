function X_new = apply_to_all_trials(func, X)
X_new ={}
for i=1:length(X)
    X_new{i} = func(X{i})
end
end