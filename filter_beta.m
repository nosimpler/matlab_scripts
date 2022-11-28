function X_new = filter_beta(X,fs)
fb = [14 29];
[b,a] = butter(5,2*fb/fs);
X_new = filtfilt(b,a,X')';
end