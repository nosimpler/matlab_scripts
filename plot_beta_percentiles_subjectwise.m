function plot_beta_percentiles_subjectwise(X,y, tpost, datatype)

if strcmp(datatype, 'mouse')
    prestim = 751:1000
    poststim = 1001:1250
    sign = 1
end

if strcmp(datatype, 'MEG')
    prestim = 451:600
    poststim = 601:750
    sign = -1
end

[X_low, y_low] = beta_percentiles_subjectwise(X, y, [0,0.5], datatype)
[X_high, y_high] = beta_percentiles_subjectwise(X,y, [0.5, 1], datatype)
% baseline-shifting
X_low = baseline_shift(X_low(:,prestim), X_low(:,poststim))
X_high = baseline_shift(X_high(:,prestim), X_high(:,poststim))

% non-shifted case
%X_low = X_low(:, 601:750)
%X_high = X_high(:, 601:750)

[pvals_high, acceptSIM, acceptPW] = exchange(X_high', y_high, tpost)
[pvals_low, acceptSIM, acceptPW] = exchange(X_low', y_low, tpost)
X_detect = [X_low; X_high]
y_detect = [y_low; y_high]

y_beta = [ones(1,size(X_high,1)), zeros(1,size(X_low,1))]
Xbeta = [X_high; X_low]
% y_beta is whether X_prestim is low or high (0 for low,
% 1 for high

% y_detect is whether stimulus was detected
% really X_beta and X_detect represent the same thing but I didn't want to 
% change the ordering

figure;
subplot(2,1,1)
hold on
plot(tpost, sign*mean(X_low(y_low == 1,:),1), 'LineWidth', 3, 'DisplayName', 'Detected')
plot(tpost, sign*mean(X_low(y_low == 0,:),1), 'LineWidth', 3, 'DisplayName', 'Nondetected')
xlabel('Time (s)')
ylabel('Dipole (Am)')
title('Low beta')
legend('show')
subplot(2,1,2)
hold on
plot(tpost, sign*mean(X_high(y_high == 1,:),1), 'LineWidth', 3)
plot(tpost, sign*mean(X_high(y_high == 0,:),1), 'LineWidth', 3)
xlabel('Time (s)')
ylabel('Dipole (Am)')
title('High beta')
figure;
hold on
plot(tpost, sign*mean(X_low,1), 'LineWidth', 3, 'DisplayName', 'Low beta')
plot(tpost, sign*mean(X_high,1), 'LineWidth', 3, 'DisplayName', 'High beta')
xlabel('Time (s)')
ylabel('Dipole (Am)')
title('All trials')
legend('show')

figure;
hold on
plot(tpost, pvals_low(:,6), 'DisplayName', 'Low beta')
plot(tpost, pvals_high(:,6), 'DisplayName', 'High beta')
title({'Exchangeability hypothesis test p-values';' (Simultaneous; alpha = 0.05)'})
xlabel('Time (s)')
ylabel('p')
legend('show')

figure;
hold on
plot(tpost, pvals_low(:,3), 'DisplayName', 'Low beta')
plot(tpost, pvals_high(:,3), 'DisplayName', 'High beta')
title({'Exchangeability hypothesis test p-values';' (Pointwise; alpha = 0.05)'})
xlabel('Time (s)')
ylabel('p')
legend('show')


[pvals_hi_lo, accSIM, accPW] = exchange(Xbeta',y_beta, tpost)
[pvals_detect, accSIM, accPW] = exchange(X_detect',y_detect, tpost)
figure; hold on
plot(tpost, pvals_hi_lo(:,6), 'DisplayName', 'Postdict beta power')
plot(tpost, pvals_high(:,6), 'DisplayName', 'High beta detection')
plot(tpost, pvals_low(:,6), 'DisplayName', 'Low beta detection')
plot(tpost, pvals_detect(:,6), 'DisplayName', 'All detection')

[pvals_hi_lo, accSIM, accPW] = exchange(Xbeta',y_beta, tpost)
[pvals_detect, accSIM, accPW] = exchange(X_detect',y_detect, tpost)
figure; hold on
plot(tpost, pvals_hi_lo(:,3), 'DisplayName', 'Postdict beta power')
plot(tpost, pvals_high(:,3), 'DisplayName', 'High beta detection')
plot(tpost, pvals_low(:,3), 'DisplayName', 'Low beta detection')
plot(tpost, pvals_detect(:,3), 'DisplayName', 'All detection')

title({'Exchangeability hypothesis test p-values';' (Pointwise; alpha = 0.05)'})
xlabel('Time (s)')
ylabel('p')
legend('show')

[pvals_hi_lo, accSIM, accPW] = exchange(Xbeta',y_beta, tpost)
[pvals_detect, accSIM, accPW] = exchange(X_detect',y_detect, tpost)
figure; hold on
plot(tpost, pvals_hi_lo(:,6), 'DisplayName', 'Prestimulus Beta')
plot(tpost, pvals_detect(:,6), 'DisplayName', 'Detection')
title({'Exchangeability hypothesis test p-values';' (Simultaneous; alpha = 0.05)'})
xlabel('Time (s)')
ylabel('p')
legend('show')


figure; hold on
plot(tpost, pvals_hi_lo(:,3), 'DisplayName', 'Prestimulus Beta')
plot(tpost, pvals_detect(:,3), 'DisplayName', 'Detection')
title({'Exchangeability hypothesis test p-values';' (Pointwise; alpha = 0.05)'})
xlabel('Time (s)')
ylabel('p')
legend('show')


