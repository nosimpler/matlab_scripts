function [X_new, timelags] = acorr(X,t)
delta_t = abs(t(2)-t(1))
for i = 1:size(X,1)
    [X_new(i,:), lags] = xcorr(X(i,:));
end
timelags = lags*delta_t
end