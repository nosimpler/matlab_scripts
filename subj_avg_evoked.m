function subj_avg_evoked(X,y,t,poststim) 
sign = -1
X_low = zeros(length(X), length(t))
X_high = zeros(length(X), length(t))
X_low_psd = zeros(length(X), 129)
X_high_psd = zeros(length(X), 129)
%y_low = zeros(length(X), length(t))
%y_high = zeros(length(X), length(t))
for i = 1:length(X)
    %[X_70, y_70] = get_equal_detect_nondetect(X{i},y{i}, 35, 'last')
     trials_low = beta_percentiles(X{i}, [0,0.5], 'hack', 'MEG')
     trials_high = beta_percentiles(X{i}, [0.5,1], 'hack', 'MEG')
     X_low(i,:) = sign*mean(X{i}(trials_low,:), 1)
     X_high(i,:) = sign*mean(X{i}(trials_high,:),1)
     size(pmtm(X_low(i,:), 2, 256, 600))
     [X_low_psd(i,:), f] = pmtm(X_low(i,:), 2, 256, 600)
     [X_high_psd(i,:), f] = pmtm(X_high(i,:), 2, 256, 600)
     %y_low(i,:) = zeros(length(trials_low),1)
     %y_high(i,:) = ones(length(trials_high),1)
end
t = t(poststim)
X_mean_low = mean(X_low,1)
X_mean_high = mean(X_high,1)

X_mean_low_psd = mean(X_low_psd,1)
X_mean_high_psd = mean(X_high_psd,1)

X_err_low = std(X_low,1)/sqrt(i)
X_err_high = std(X_high,1)/sqrt(i)

X_err_low_psd = std(X_low_psd,1)/sqrt(i)
X_err_high_psd = std(X_high_psd,1)/sqrt(i)

figure
hold on
errorbar(t, X_mean_low(poststim), X_err_low(poststim))
errorbar(t, X_mean_high(poststim), X_err_high(poststim))

xlabel('Time (s)')
ylabel('Dipole (Am)')
title('Evoked response')

figure
hold on

h1 = errorbar(f, X_mean_low_psd, X_err_low_psd)
h2 = errorbar(f, X_mean_high_psd, X_err_high_psd)
set(get(h1,'Parent'), 'YScale', 'log')
set(get(h2,'Parent'), 'YScale', 'log')
xlabel('Frequency (Hz)')
ylabel('log(PSD)')
title('Evoked PSD')
     
     