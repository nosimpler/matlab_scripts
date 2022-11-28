function rad_diff = diff_rad(X, y)
y_new = y(randperm(length(y)));
mean0 = c_rad(X(y_new==0,:));
mean1 = c_rad(X(y_new==1,:));
rad_diff = mean1-mean0;
end