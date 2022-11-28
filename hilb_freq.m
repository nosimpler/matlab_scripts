function X_new = hilb_freq(X)
X_new = diff(unwrap(angle(hilbert(X')'), [], 2), 1, 2)
end