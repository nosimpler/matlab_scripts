function X_new = beta_phase(X,fs)
X_new = unwrap(angle(hilbert(filter_beta(X,fs)')'), [], 2)
end