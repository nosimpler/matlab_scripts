function [X_new,y_new] = agg_func(func, X,y)
[X_new, y_new] = aggregate_data(apply_to_all_trials(func, X),y)
end