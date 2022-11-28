%assume X is bands x timepts x trials 

function [event_times, trials] = find_event_times(X)
t = linspace(0,1,size(X,2)+2)
factor = 6
freq_bp = 14:29
low_f = min(freq_bp)
%median_X = squeeze(median(X(freq_bp,:,:), 3));
median_X = get_median(X(freq_bp,:,:))

event_times = []
trials = []
X_bp = squeeze(sum(X(freq_bp,:,:),1));
for trial_idx = 1:size(X,3)
    for freq_idx = 1:length(freq_bp)
        freq = freq_idx+low_f-1;
        
        peaks(freq_idx,:) = [0, (X(freq,:,trial_idx)>factor*median_X(freq_idx)), 0];
        %peaks(freq_idx,:) = [0, (X(freq,:,trial_idx)>factor*median_X), 0];
    end
    peaktimes = (sum(peaks, 1) > 0);
    
    peakstarts = (diff(peaktimes) == 1);
    n_pks(trial_idx) = sum(peakstarts);
    peakends = (diff(peaktimes) == -1);
    
    peakstarts_idx = find(peakstarts);
    peakends_idx = find(peakends);
    t_max = [];
    
    for peak_idx = 1:sum(peakstarts)
        X_peak = X_bp(peakstarts_idx(peak_idx):peakends_idx(peak_idx)-1,trial_idx);
        localmax_idx = find(max(X_peak) == X_peak);
        max_idx = localmax_idx + peakstarts_idx(peak_idx);
        t_max = [t_max t(max_idx)];
        trials = [trials, trial_idx]
    end
    event_times = [event_times t_max];
    
end
event_times = event_times'
trials = trials'
end

    