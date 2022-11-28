function [W, H] = nnmf_spectrum(X)
fs = 600
n_timepoints = size(X, 2)
f = linspace(0, fs, n_timepoints)
spectrum = pmtm(X', 8, f, fs)'
[W, H] = nnmf(spectrum, 3)
end
