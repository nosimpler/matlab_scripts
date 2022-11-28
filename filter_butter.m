function X_new = filter_butter(X, fs, fb)
[b,a] = butter(5,2*fb/fs);
X_new = filtfilt(b,a,X')';
end