function plot_conditional_PSDs(X, y, t, poststim, datatype)


ALPHA = 0.1
NFFT = 256
TBW = 4
if strcmp(datatype, 'mouse')
    prestim = 1:1000
    sign = 1
    fs = 1000
    offset = 0
end
if strcmp(datatype, 'attention')
    prestim = 1101:1200
    sign = -1
    fs = 600
    offset = 0
end
if strcmp(datatype, 'MEG')
    prestim = 1:600
    sign = -1
    fs = 600
    offset = 1000
end

t = t(poststim)*1000 - offset;



% split by hi/lo
[X_low, y_low] = beta_percentiles_subjectwise(X, y, [0,0.5], prestim, fs)
[X_high, y_high] = beta_percentiles_subjectwise(X,y, [0.5, 1], prestim, fs)
[X_low,f] = pmtm(X_low(:, poststim)', TBW, NFFT, fs, 'Droplasttaper', false)
[X_high, f] = pmtm(X_high(:, poststim)', TBW, NFFT, fs, 'Droplasttaper', false)
X_high = X_high'
X_low = X_low'
% recombine to get detection variables
X_detect = [X_low; X_high];
y_detect = [y_low; y_high];

% split by detection
X_yes = X_detect(y_detect == 1, :)
X_no = X_detect(y_detect == 0, :)



% new indicator variables for postdiction of beta
y_beta = [zeros(1,size(X_low,1)), ones(1,size(X_high,1))]
y_yes = y_beta(y_detect == 1)
y_no = y_beta(y_detect == 0)
X_beta = [X_low; X_high]

% try to predict detection given high/low and poststim
% waveform
mu_high_yes = sign*mean(X_high(y_high == 1,:))
mu_high_no = sign*mean(X_high(y_high == 0,:))
mu_low_yes = sign*mean(X_low(y_low == 1,:))
mu_low_no = sign*mean(X_low(y_low == 0,:))
[pvals_high, acceptSIM, acceptPW] = exchange(X_high', y_high, f)
[pvals_low, acceptSIM, acceptPW] = exchange(X_low', y_low, f)

SIMlog_high = pvals_high(:,6) < ALPHA
PWlog_high = pvals_high(:,3) < ALPHA
SIMlog_low = pvals_low(:,6) < ALPHA
PWlog_low = pvals_low(:,3) < ALPHA
figure; subplot(2,1,1)

[p1pre, p2pre] = TS_signif(log10(mu_high_yes), log10(mu_high_no), f, SIMlog_high', PWlog_high')
title('Detection indicators | high beta')
legend([p1pre, p2pre], {'Detected', 'Nondetected'})
subplot(2,1,2)
[p3pre, p4pre] = TS_signif(log10(mu_low_yes), log10(mu_low_no), f, SIMlog_low', PWlog_low')
title('Detection indicators | low beta')
% try to postdict high/low given detection and poststim
% waveform

mu_yes_high = sign*mean(X_yes(y_yes == 1,:))
mu_yes_low = sign*mean(X_yes(y_yes == 0,:))
mu_no_high = sign*mean(X_no(y_no == 1,:))
mu_no_low = sign*mean(X_no(y_no == 0,:))
[pvals_yes, acceptSIM, acceptPW] = exchange(X_yes', y_yes, f)
[pvals_no, acceptSIM, acceptPW] = exchange(X_no', y_no, f)
SIMlog_yes = pvals_yes(:,6) < ALPHA
PWlog_yes = pvals_yes(:,3) < ALPHA
SIMlog_no = pvals_no(:,6) < ALPHA
PWlog_no = pvals_no(:,3) < ALPHA
figure; subplot(2,1,1)
[p1post, p2post] = TS_signif(log10(mu_yes_low), log10(mu_yes_high), f, SIMlog_yes', PWlog_yes')
title('Beta power indicators | Detected')
legend([p1post, p2post], {'Low beta', 'High beta'})
subplot(2,1,2)
[p3post, p4post] = TS_signif(log10(mu_no_low), log10(mu_no_high), f, SIMlog_no', PWlog_no')
title('Beta power indicators | Nondetected')


% Use all data to predict detection
[pvals_detect, acceptSIM, acceptPW] = exchange(X_detect', y_detect, f)
SIMlog_detect = pvals_detect(:,6) < ALPHA
PWlog_detect = pvals_detect(:,3) < ALPHA

mu_yes = mean(X_yes)
mu_no = mean(X_no)
figure;
subplot(2,1,1)
[p0_det, p1_det] = TS_signif(log10(mu_yes), log10(mu_no), f, SIMlog_detect', PWlog_detect')
title('Detection indicators')

legend([p0_det, p1_det], {'Detected', 'Nondetected'})



% Use all data to postdict beta

[pvals_beta, acceptSIM, acceptPW] = exchange(X_beta', y_beta, f)
SIMlog_beta = pvals_beta(:,6) < ALPHA
PWlog_beta = pvals_beta(:,3) < ALPHA
mu_high = sign*mean(X_beta(y_beta == 1, :))
mu_low = sign*mean(X_beta(y_beta == 0, :))
subplot(2,1,2) 
[p1, p2] = TS_signif(log10(mu_low), log10(mu_high), f, SIMlog_beta', PWlog_beta')
title('Beta power indicators')
xlabel('Frequency (Hz)')
ylabel('Power spectral density')
legend([p1, p2], {'Low beta', 'High beta'})



end