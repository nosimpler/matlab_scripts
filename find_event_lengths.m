%assume X is bands x timepts x trials 

function [event_lengths, trials] = find_event_lengths(X)
t = linspace(0,1,size(X,2)+2);
factor = 6;
freq_bp = 14:29;
low_f = min(freq_bp);
%median_X = squeeze(median(X(freq_bp,:,:), 3));
median_X = get_median(X(freq_bp,:,:));

event_lengths = []
X_bp = squeeze(sum(X(freq_bp,:,:),1));
trials = []
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
    
    for i =1:sum(peakstarts)
        event_lengths = [event_lengths abs(t(peakstarts_idx(i)) - t(peakends_idx(i)))];
        trials = [trials, trial_idx]
    end
end
event_lengths = event_lengths';
trials = trials'
end

    