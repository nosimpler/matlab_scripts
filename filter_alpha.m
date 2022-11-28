function X_new = filter_alpha(X,fs)
fb = [11 13];
[b,a] = butter(3,2*fb/fs);
X_new = filtfilt(b,a,X')';
end