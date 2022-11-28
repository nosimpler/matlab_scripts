function plot_subjwise_beta_indicators_PSD(X_all, y_all, t, poststim, datatype, func)
% Use all data to postdict beta



ALPHA = 0.1
NFFT = 256
TBW = 2

if strcmp(datatype, 'mouse')
    prestim = 1:1000

    sign = 1
    fs = 1000
end
if strcmp(datatype, 'attention')
    prestim = 1051:1200
    sign = -1
    fs = 600
    t = t(poststim)
    titlestring = 'Attention indicators'
    legendstring = {'Attend in', 'Attend out'}
    titlestring_beta1 = 'Beta power postdictors | Attend in'
    titlestring_beta2 = 'Beta power postdictors | Attend out'
end
if strcmp(datatype, 'MEG')
    prestim = 1:600
    titlestring = 'Detection indicators'
    titlestring_beta1 = 'Beta power postdictors | Detected'
    titlestring_beta2 = 'Beta power postdictors | Not detected'
    sign = -1
    fs = 600
    f_lims = [0,300]
end

t = t(poststim)


figure;
for i = 1:length(X_all)
    X = X_all(i)
    if func
        X = func(X)
    end
    y = y_all(i)

    subplot(4,3,i)
    % split by hi/lo
    [X_low, y_low] = beta_percentiles_subjectwise(X, y, [0,0.5], prestim, fs)
    [X_high, y_high] = beta_percentiles_subjectwise(X,y, [0.5, 1], prestim, fs)
    [X_low,f] = pmtm(X_low(:, poststim)', TBW, NFFT, fs, 'Droplasttaper', false)
    [X_high, f] = pmtm(X_high(:, poststim)', TBW, NFFT, fs, 'Droplasttaper', false)
    
    %[X_low,f] = pmtm(X_low(:, poststim)', TBW, NFFT, fs, 'Droplasttaper', false)
    %[X_high, f] = pmtm(X_high(:, poststim)', TBW, NFFT, fs, 'Droplasttaper', false)
    
    X_high = X_high'
    X_low = X_low'
    %X_low = X_low(:, poststim);
    %X_high = X_high(:, poststim);
    % recombine to get detection variables
    X_detect = [X_low; X_high];
    y_detect = [y_low; y_high];
    sign = 1
    % split by detection
    X_yes = X_detect(y_detect == 1, :)
    X_no = X_detect(y_detect == 0, :)



    % new indicator variables for postdiction of beta
    y_beta = [zeros(1,size(X_low,1)), ones(1,size(X_high,1))]
    y_yes = y_beta(y_detect == 1)
    y_no = y_beta(y_detect == 0)
    X_beta = [X_low; X_high]

    [pvals_beta, acceptSIM, acceptPW] = exchange(X_beta', y_beta, t)
    SIMlog_beta = pvals_beta(:,6) < ALPHA
    PWlog_beta = pvals_beta(:,3) < ALPHA
    mu_high = sign*mean(X_beta(y_beta == 1, :))
    mu_low = sign*mean(X_beta(y_beta == 0, :))
    [p1(i), p2(i)] = TS_signif(mu_low, mu_high, f, SIMlog_beta', PWlog_beta')
    title(['Subject ', num2str(i)])
    xlabel('Frequency')
    ylabel('PSD')
    xlim(f_lims)
end
suptitle(['Poststimulus beta power indicators '])
legend([p1(i), p2(i)], {'Low beta', 'High beta'})
end