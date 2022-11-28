%assume X is bands x timepts x trials 

function n_pks = count_peaks(X)
t = linspace(0,1,size(X,2))
factor = 1.5
freq_bp = 14:29
low_f = min(freq_bp)
median_X = squeeze(median(X(freq_bp,:,:), 3));

IEIs = []
X_bp = squeeze(sum(X(freq_bp,:,:),1));
for trial_idx = 1:size(X,3)
    for freq_idx = 1:length(freq_bp)
        freq = freq_idx+low_f-1;
        
        peaks(freq_idx,:) = [0, (X(freq,:,trial_idx)>factor*median_X(freq_idx,:))];
    end
    peaktimes = (sum(peaks, 1) > 0);
    peakstarts = (diff(peaktimes) == 1);
    n_pks(trial_idx) = sum(peakstarts);
end
n_pks = n_pks'
end

    