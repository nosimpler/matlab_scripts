function plot_subjwise_detection_indicators_PSD(X_all, y_all, t, poststim, datatype, func)
% Use all data to postdict beta



ALPHA = 0.1
TBW = 2
NFFT = 256
beta_percent = 0.5
if strcmp(datatype, 'mouse')
    prestim = 751:1000

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
    fr = 300
t = t(poststim)*1000-1000
end



figure;
for i = 1:length(X_all)
    X = X_all(i)
    if func
        X = func(X)
    end
    y = y_all(i)

    subplot(4,3,i)
    % split by hi/lo
    [X_low, y_low] = beta_percentiles_subjectwise(X, y, [0,beta_percent], prestim, fs)
    [X_high, y_high] = beta_percentiles_subjectwise(X,y, [1-beta_percent, 1], prestim, fs)
    sign = 1
  
    [X_low,f] = pmtm(X_low(:, poststim)', TBW, NFFT, fs, 'Droplasttaper', false)
    [X_high, f] = pmtm(X_high(:, poststim)', TBW, NFFT, fs, 'Droplasttaper', false)
    X_high = X_high'
    X_low = X_low'
    %X_low = X_low(:, poststim);
    %X_high = X_high(:, poststim);
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

    [pvals_beta, acceptSIM, acceptPW] = exchange(X_detect', y_detect, f)
    SIMlog_beta = pvals_beta(:,6) < ALPHA
    PWlog_beta = pvals_beta(:,3) < ALPHA
    mu_yes = sign*mean(X_detect(y_detect == 1, :))
    mu_no = sign*mean(X_detect(y_detect == 0, :))
    %bug in y axis is because simlog_beta hasn't been truncated
    [p1(i), p2(i)] = TS_signif(mu_yes(f<fr), mu_no(f<fr), f(f<fr), SIMlog_beta(f<fr)', PWlog_beta(f<fr)')
    title(['Subject ', num2str(i),''])
    xlabel('Frequency (Hz)')
    ylabel('PSD')
    
end
suptitle(['Poststimulus detection indicators'])

legend([p1(i), p2(i)], {'Detected', 'Nondetected'})
end