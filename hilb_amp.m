function amp = hilb_amp(X)
H = hilbert(X')';
amp = abs(H);
end