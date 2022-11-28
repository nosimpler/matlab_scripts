function plot_all_subjs_beta(X, y, t, t_idx)
N = 70
% take top and bottom beta quantiles
B = 0.5
PREBETA = 501:600
PREBASELINE = 511:600

Mu_high = zeros(1,2101)
Mu_low = zeros(1,2101)
Mu_high_collection = []
Mu_low_collection = []
for i = 1:length(X)
    subplot(ceil(length(X)/3),3,i);
    X_i = X{i};
    y_i = y{i}
    hold on
    
    X_high_trial_idx = beta_percentiles(X_i(:,PREBETA), [1-B,1], 'mtm', 'MEG');
    X_high = X_i(X_high_trial_idx,:);
    y_high = y_i(X_high_trial_idx);
    [X_eq_high, y_eq_high] = get_equal_detect_nondetect(X_high, y_high, N/2, 'last');
    X_eq_high = baseline_shift(X_eq_high(:,PREBASELINE),X_eq_high)
    
    X_low_trial_idx  = beta_percentiles(X_i(:,PREBETA), [0,B], 'mtm', 'MEG');
    X_low = X_i(X_low_trial_idx,:);
    y_low = y_i(X_low_trial_idx);
    [X_eq_low, y_eq_low] = get_equal_detect_nondetect(X_low, y_low, N/2, 'last');
    X_eq_low = baseline_shift(X_eq_low(:,PREBASELINE),X_eq_low)
    
    
    mu_high = mean(X_eq_high, 1);
    sigma_high = std(X_eq_high, 1);
    mu_low = mean(X_eq_low, 1);
    sigma_low = std(X_eq_low, 1);
    errorbar(t(t_idx), -mu_low(t_idx), sigma_low(t_idx)/sqrt(N));
    errorbar(t(t_idx), -mu_high(t_idx), sigma_high(t_idx)/sqrt(N));
    title(['Subject ', num2str(i)]);
    xlabel('time (ms)')
    ylabel('Dipole (Am)')
    if i == 1
        legend({'Low beta', 'High beta'});
    end
    hold off;
    size(mu_high)
    size(Mu_high)
    Mu_high_collection = [Mu_high_collection; mu_high]
    Mu_low_collection = [Mu_low_collection; mu_low]
    Mu_high = Mu_high + mu_high/N
    Mu_low = Mu_low + mu_low/N
    
end
suptitle({'High (top 50%) vs. low (bottom 50%) beta';'(35 detected, 35 nondetected per subset)'})
i
err_high = std(Mu_high_collection, 1)/sqrt(i)
err_low = std(Mu_low_collection, 1)/sqrt(i)
figure;
hold on;
errorbar(t(t_idx), -Mu_low(t_idx), err_low(t_idx))
errorbar(t(t_idx), -Mu_high(t_idx), err_high(t_idx))
legend({'Low beta', 'High beta'})

end