function mean_diff = circular_mean_diff(X, y)
y_new = y(randperm(length(y)));
mean0 = circmean(X(y_new==0,:));
mean1 = circmean(X(y_new==1,:));
mean_diff = mod(mean1-mean0, pi);
end