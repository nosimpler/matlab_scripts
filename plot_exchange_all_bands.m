function pvals = plot_exchange_all_bands(X,y,t)
%prefix = '~/Desktop/rob_beta_paper/permutation_tests/human_TFR'
prefix = '~/Desktop/2016-06-22/exchange_TFR/mouse'
%prefix = '~/Desktop/2016-06-22/exchange_TFR/attention'
[nf,ntime,ntrials] = size(X);
X_new = zeros(ntrials, nf*ntime);

for trial_idx = 1:ntrials
    X_trial = [];
    for freq_idx = 1:nf
        X_trial = [X_trial, X(freq_idx, :, trial_idx)];
    end
    X_new(trial_idx,:) = X_trial;
end
%X = permute(X, [2,1,3]);

size(X_new)
[pvals, acceptPW, acceptSIM] = exchange(X_new', y, t);
p = pvals(:,3);
p_new = zeros(nf, ntime)
for freq_idx = 1:nf
    p_new(freq_idx, :) = p(1:ntime)
    p(1:ntime) = []
end
p_new(p_new>0.05) = 1;
%p_new = p_new(end:-1:1, :)
imagesc(log10(p_new))
set(gca, 'YDir', 'normal')
%colorbar('FontSize',11,'YTick',log10(p_new),'YTickLabel',p_new);
colorbar()
%files = prefix;
%saveas(gcf, files);
    

%agg_file = [prefix,'.pdf']
%append_pdfs(agg_file, files{:})

end