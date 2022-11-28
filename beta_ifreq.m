function X_new = beta_ifreq(X,fs)
X_new = diff(unwrap(angle(hilbert(filter_beta(X,fs)')'), [], 2), 1, 2)
end