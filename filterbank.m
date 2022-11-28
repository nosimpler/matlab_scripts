function X_new = filterbank(X, fs)
BANDS = ... 
    [1 2;
    3 7;
    8 14;
    15 29;
    29 50]
n_t = size(X,2);
n_trials = size(X, 1);
n_bands = size(BANDS, 1);
X_new = zeros(n_bands, n_t, n_trials);
for i = 1:n_bands
    for j = 1:n_trials
        X_new(i,:,j) = filter_cheby(X(j,:), fs, BANDS(i,:));
    end
end
end
    