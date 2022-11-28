function ac = filter_autocorr(t)
[b,a] = butter(3, [14, 30]/300)
impulse=[1, zeros(1, length(t)-1)]
out = filtfilt(b,a,impulse)
ac = xcorr(out, 'coeff')
end