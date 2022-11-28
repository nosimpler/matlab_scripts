%assume X is bands x timepts x trials 

function IEIs = find_IEIs(t,X)
factor = 3
X_bp = squeeze(sum(X(14:29,:,:),1);
median_bp = median(X_bp, 2);
peaktimes = (X_bp>factor*median_bp)
IEIs = []
for trial_idx = 1:size(peaktimes,2)
    peakstarts = [0 (diff(peaktimes) == 1)]
    n_pks(trial_idx) = sum(peakstarts)
    peakends = [0 (diff(peaktimes) == -1)]
    if peakstarts > peakends
        peakends = [peakends, 1]
    end
    peakstarts_idx = find(peakstarts)
    peakends_idx = find(peakends)
    t_max = []
    for peak_idx = 1:length(peakstarts)
        X_peak = X_bp(peakstarts_idx(peak_idx):peakends_idx(peak_idx),trial_idx)
        localmax_idx = find(max(X_peak) == X_peak)
        max_idx = localmax_idx + peakstarts_idx(peak_idx)
        t_max = [t_max t(max_idx)]
    end
    IEIs = [IEIs diff(t_max)]
end
end

    