function X_new = beta_hilbert(X, fs)
X_new = hilb_amp(filter_beta(X, fs))
end