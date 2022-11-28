%assume X is bands x timepts x trials 

function null_IEI = null_IEI_dist2(X)
%1 second interval
interval = 1.0
t = linspace(0,1,size(X,2)+2);
factor = 6;
freq_bp = 14:29;
low_f = min(freq_bp);
median_X = get_median(X(freq_bp,:,:));
%median_X = squeeze(median(X(freq_bp,:,:), 3));
null_IEI = []
event_lengths = []
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
    event_lengths = [];
    t_max = []
    max_shift = []
    for peak_idx = 1:sum(peakstarts)
        X_peak = X_bp(peakstarts_idx(peak_idx):peakends_idx(peak_idx)-1,trial_idx);
        localmax_idx = find(max(X_peak) == X_peak);
        max_idx = localmax_idx + peakstarts_idx(peak_idx);
        t_max = [t_max t(max_idx)];
        % shift between leading edge and max
        max_shift = [max_shift t(peakends_idx(peak_idx))-t(max_idx)]
    end
    for i =1:length(peakstarts_idx)
        event_lengths = [event_lengths abs(t(peakstarts_idx(i)) - t(peakends_idx(i)))];
        
    end
    if length(peakstarts_idx) > 1
        null_IEI = [null_IEI place_nonoverlap(event_lengths, interval, max_shift)];
    end
    
    
end
null_IEI = null_IEI'
end