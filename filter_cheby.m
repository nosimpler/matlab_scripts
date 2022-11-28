function X_new = filter_cheby(X, fs, fb)
[b,a] = cheby1(3,3,2*fb/fs);
X_new = filtfilt(b,a,X')';
end