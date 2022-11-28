function plot_conditional_stats(X, y, t, datatype)

ALPHA = 0.1
BAND = [20,29]
if strcmp(datatype, 'mouse')
    prestim = 1:1000
    poststim = 1001:1250
    sign = 1
    fs = 1000
end
if strcmp(datatype, 'attention')
    prestim = 601:1200
    poststim = 1:2100
    sign = -1
    fs = 600
end
if strcmp(datatype, 'MEG')
    %prestim = 451:600
    
    %based on IEI
    prestim = 1:600
    poststim = 601:750
    sign = -1
    fs = 600
end
t = t(poststim)
% split by hi/lo

[X_low, y_low] = beta_percentiles_subjectwise(X, y, [0,0.5], prestim, fs);
[X_high, y_high] = beta_percentiles_subjectwise(X,y, [0.5, 1], prestim, fs);
X_low = X_low(:, poststim);
X_high = X_high(:, poststim);

%insert filters/transforms here
%set sign to 1 for hilbert power
sign = -1

%X_low = filter_butter(X_low, fs, BAND);
%X_high = filter_butter(X_high, fs, BAND);
%X_low = abs(hilbert(X_low))
%X_high = abs(hilbert(X_high))
%X_low = hilb_freq(X_low)*fs/(2*pi)
%X_high = hilb_freq(X_high)*fs/(2*pi)
X_low = TVRD(X_low)
X_high = TVRD(X_high)
%poststim(end) = []
%t(end) = []
% just to check
figure; hold on
%for i = 1:size(X_low, 1)
%    if y_low(i) == 1
        
%        plot(t,X_low(i,:), 'b')
%    else
%        plot(t,X_low(i,:), 'r')
%    end
%    pause
    
%end
l1 = plot(t, X_high(y_high == 1, :), 'b')

l2 = plot(t, X_high(y_high == 0, :), 'r')

figure; hold on

l3 = plot(t, X_low(y_low == 1, :), 'b')

l4 = plot(t, X_low(y_low == 0, :), 'r')

figure; hold on
exchange_viz(X_high', y_high, t)

% hit rates etc.
%length(y_low(y_low == 0))
%length(y_low(y_low == 1))
%length(y_high(y_high == 0))
%length(y_high(y_high == 1))
%pause

% recombine to get 
X_detect = [X_low; X_high]
y_detect = [y_low; y_high]

% split by detection
X_yes = X_detect(y_detect == 1, :)
X_no = X_detect(y_detect == 0, :)
figure; hold on
l5 = plot(t, X_yes, 'b')
l6 = plot(t, X_no, 'r')
xlabel('Peristimulus time (s)')
ylabel('Dipole (Am)')
title('All dipoles (attention task)')
legend([l5(1), l6(1)], {'Attend in', 'Attend out'})
% Overall detection statistics for extreme samples
[pvals_detect, acceptSIM, acceptPW] = exchange(X_detect', y_detect, t)
SIMlog_detect = pvals_detect(:,6) < ALPHA
PWlog_detect = pvals_detect(:,3) < ALPHA

mu_yes = sign*mean(X_yes)
mu_no = sign*mean(X_no)
figure;
[p0_det, p1_det] = TS_signif(mu_yes, mu_no, t, SIMlog_detect', PWlog_detect')
title('Predict detection using extremal waveforms')
legend([p0_det, p1_det], {'Detected', 'Nondetected'})
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
[pvals_high, acceptSIM, acceptPW] = exchange(X_high', y_high, t)
[pvals_low, acceptSIM, acceptPW] = exchange(X_low', y_low, t)

%can change these to indicate better
%pointwise agreement and simultaneous
SIMlog_high = pvals_high(:,6) < ALPHA
PWlog_high = pvals_high(:,3) < ALPHA
SIMlog_low = pvals_low(:,6) < ALPHA
PWlog_low = pvals_low(:,3) < ALPHA
figure; subplot(2,1,1)

[p1pre, p2pre] = TS_signif(mu_high_yes, mu_high_no, t, SIMlog_high', PWlog_high')
title('Detection predictors | high beta')
legend([p1pre, p2pre], {'Detected', 'Nondetected'})
subplot(2,1,2)
[p3pre, p4pre] = TS_signif(mu_low_yes, mu_low_no, t, SIMlog_low', PWlog_low')
title('Detection predictors | low beta')
% try to postdict high/low given detection and poststim
% waveform

mu_yes_high = sign*mean(X_yes(y_yes == 1,:))
mu_yes_low = sign*mean(X_yes(y_yes == 0,:))
mu_no_high = sign*mean(X_no(y_no == 1,:))
mu_no_low = sign*mean(X_no(y_no == 0,:))
[pvals_yes, acceptSIM, acceptPW] = exchange(X_yes', y_yes, t)
[pvals_no, acceptSIM, acceptPW] = exchange(X_no', y_no, t)
SIMlog_yes = pvals_yes(:,6) < ALPHA
PWlog_yes = pvals_yes(:,3) < ALPHA
SIMlog_no = pvals_no(:,6) < ALPHA
PWlog_no = pvals_no(:,3) < ALPHA
figure; subplot(2,1,1)
[p1post, p2post] = TS_signif(mu_yes_high, mu_yes_low, t, SIMlog_yes', PWlog_yes')
title('Beta power postdictors | Detected')
legend([p1post, p2post], {'High beta', 'Low beta'})
subplot(2,1,2)
[p3post, p4post] = TS_signif(mu_no_high, mu_no_low, t, SIMlog_no', PWlog_no')
title('Beta power postdictors | Nondetected')


% Use all data to postdict beta

[pvals_beta, acceptSIM, acceptPW] = exchange(X_beta', y_beta, t)
SIMlog_beta = pvals_beta(:,6) < ALPHA
PWlog_beta = pvals_beta(:,3) < ALPHA
mu_high = sign*mean(X_beta(y_beta == 1, :))
mu_low = sign*mean(X_beta(y_beta == 0, :))
figure; 
[p1, p2] = TS_signif(mu_low, mu_high, t, SIMlog_beta', PWlog_beta')
title('Postdict beta power')
legend([p1, p2], {'Low beta', 'High beta'})



end