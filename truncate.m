function new_X = truncate(X,t,t0,tf)
new_X = X(:, t<=tf && t>=t0)
end
