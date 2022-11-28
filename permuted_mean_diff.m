%according to Harrison
function mean_diff = permuted_mean_diff(X,y)
y_new = y(randperm(length(y)));
mean0 = mean(X(y_new==0,:));
mean1 = mean(X(y_new==1,:));
mean_diff = mean1-mean0;
end
