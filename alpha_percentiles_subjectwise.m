function [X_new, y_new] = alpha_percentiles_subjectwise(X, y, bounds, prestim_period, fs)
lb = bounds(1);
ub = bounds(2);
%if strcmp(datatype, 'MEG')
%    prestim_period = 500:600
%elseif strcmp(datatype, 'mouse')
%    prestim_period = 751:1000
%end
n_subjects = length(X);
X_new = [];
y_new = []
for subj = 1:n_subjects
    %X{subj} = X{subj}(end-99:end, :)
    %y{subj} = y{subj}(end-99:end)
    n_trials = size(X{subj},1)
    min_trial = floor(lb*n_trials)+1
    max_trial = floor(ub*n_trials)
    beta_power = []
    for i = 1:n_trials
        [pxx,f] = pmtm(X{subj}(i,prestim_period), 4, 256, fs);

        beta_power(i) = sum(pxx(f<=13 & f>=9));
    end
    [B,I] = sort(beta_power);
    trials = I(min_trial:max_trial)
    size(X{subj})
    size(X{subj}(trials,:))
    X_new = [X_new; X{subj}(trials,:)];
    y_new = [y_new; y{subj}(trials)];
    size(X_new)
end
end
