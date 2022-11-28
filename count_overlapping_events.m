function n = count_overlapping_events(X)
%1 second interval

t = linspace(0,1,size(X,2)+2);
factor = 6;
freq_bp = 14:29;
low_f = min(freq_bp);
median_X = get_median(X(freq_bp,:,:));
%median_X = squeeze(median(X(freq_bp,:,:), 3));
for trial_idx = 1:size(X,3)
    for freq_idx = 1:length(freq_bp)
        freq = freq_idx+low_f-1;
        over_thresh = (X(freq,:,trial_idx)>factor*median_X(freq_idx));
        
        Xot(freq_idx,:) = X(freq, :, trial_idx).*over_thresh;
        %peaks(freq_idx,:) = [0, (X(freq,:,trial_idx)>factor*median_X), 0];
    end
    %Xt = squeeze(X(:,:,trial_idx));
    peak_indices = find(imregionalmax(Xot));
    
    n(trial_idx) = length(peak_indices);
    

    
end
n = n'
