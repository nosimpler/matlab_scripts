function fftphase = phase_distribution(X)
fftphase = angle(fftshift(fft(X')))';
end
