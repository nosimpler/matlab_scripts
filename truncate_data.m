function [new_X, new_t] = truncate_data(X,t,t0,tf)
new_X = X(:, t<=tf & t>=t0);
new_t = t(t<=tf & t>=t0)
end
