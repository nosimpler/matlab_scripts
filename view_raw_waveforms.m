function view_raw_waveforms(X, t, range)
for trial = 1:size(X,2)
    plot(t(range), X(trial, range))
    pause
    close all
end
end