% run on raw signal
function trials = beta_percentiles(X, bounds, method, datatype)
lb = bounds(1);
ub = bounds(2);
if datatype == 'MEG'
    CUTOFFTIME = 600
elseif datatype == 'mouse'
    CUTOFFTIME == 1500
end
n_trials = size(X,1);
min_trial = floor(lb*n_trials)+1;
max_trial = floor(ub*n_trials);
if strcmp(method,'hack')
    for i = 1:n_trials
        [pxx,f] = pmtm(X(i,451:600), 4, 256, 600);
        
        beta_power(i) = sum(pxx(f<=29 & f>=15));
    end
elseif strcmp(method,'mtm')
    for i = 1:n_trials
        [pxx,f] = pmtm(X(i,:), 4, 256, 600);
        
        beta_power(i) = sum(pxx(f<=29 & f>=15));
    end
elseif strcmp(method, 'preTFR')
    for i = 1:n_trials
        [TFR, timevec, freqvec] = traces2TFR(X(i,:)',15:29, 600, 7);
        size(TFR);
        beta_power(i) = mean(mean(TFR));
    end
    
elseif strcmp(method, 'prepostTFR')
    for i = 1:n_trials
        [TFR, timevec, freqvec] = traces2TFR(X(i,:)',15:29, 600, 7);
        size(TFR);
        TFR = TFR(:,1:CUTOFFTIME);
        beta_power(i) = mean(mean(TFR));
    end
end
[B,I] = sort(beta_power);
B(1)
B(end)
B(min_trial:max_trial);
trials = I(min_trial:max_trial);