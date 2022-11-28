function X_new = power_cepstrum(X)
X_new = ifft(log(abs(fft(X'))))
end