%returns indices bounding time intervals for beta events 

function [trials, time_interval_idx, max_idx] = get_events(X)
trials = {};
time_interval_idx = {};
max_idx = {}
t = linspace(0,1,size(X,2)+2);
factor = 6;
freq_bp = 14:29;
low_f = min(freq_bp);
%median_X = squeeze(median(X(freq_bp,:,:), 3));
median_X = get_median(X(freq_bp,:,:));

%calculate summed bandpassed signal for
%peakfinding after thresholds are detected
X_bp = squeeze(sum(X(freq_bp,:,:),1));
event_idx = 1
for trial_idx = 1:size(X,3)
    for freq_idx = 1:length(freq_bp)
        freq = freq_idx+low_f-1;
        %peaks are regions above threshold
        %should maybe be called 'events' instead
        peaks(freq_idx,:) = [0, (X(freq,:,trial_idx)>factor*median_X(freq_idx)), 0];
        %peaks(freq_idx,:) = [0, (X(freq,:,trial_idx)>factor*median_X), 0];
    end
    %if any frequency crosses threshold, count as an event
    peaktimes = (sum(peaks, 1) > 0);
    %use diff to find indices where events begin and end
    peakstarts = (diff(peaktimes) == 1);
    n_pks(trial_idx) = sum(peakstarts);
    peakends = (diff(peaktimes) == -1);
    
    peakstarts_idx = find(peakstarts);
    peakends_idx = find(peakends);
    t_max = [];
    
    %find time of actual bandpassed waveform peak
    for peak_idx = 1:sum(peakstarts)
        X_peak = X_bp(peakstarts_idx(peak_idx):peakends_idx(peak_idx)-1,trial_idx);
        
        localmax_idx = find(max(X_peak) == X_peak);
        max_idx{event_idx} = localmax_idx + peakstarts_idx(peak_idx);

        time_interval_idx{event_idx} = [peakstarts_idx(peak_idx), peakends_idx(peak_idx)-1]
        
        trials{event_idx} = trial_idx
        event_idx = event_idx + 1;
    end
    
    
end

end
