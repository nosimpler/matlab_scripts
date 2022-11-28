function X_mean = circmean(X)
r = sum(exp(1i*X),1);
X_mean = angle(r);
end