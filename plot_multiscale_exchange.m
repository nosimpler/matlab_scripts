%X is TFR
function plot_multiscale_exchange(X, y, alpha)
reject_null_idx = []
X_permute = []
for freq_idx = 1:size(X,1)
    X_freq = squeeze(X(freq_idx,:,:));
   
    y = y';
% ------------------------------------------------------------------------
% create some fake data --------------------------------------------------
% ------------------------------------------------------------------------

% Replace this section with loading your own data.
% The data D should be a TxN matrix of N trials and T time points per trial.
% The labels L should be a 1xN vector of 1's and 2's indicating the trial
%  type.

% create labels
    N = size(X_freq,2);
    L = y+1;
    T = size(X_freq,1)
    D = X_freq;

% ------------------------------------------------------------------------
% create the function to compute the differences between labels ----------
% ------------------------------------------------------------------------

% Replace this section with a function that compares the two types of
%  trials. The the data D is fixed and the function should only depend
%  on the labels. The function below simply computes the difference
%  between the average from trial type 1 and the average from trial type 2.
%  This function might be good enough for what you want. 
%
% You can incorporate temporal smoothing/binning here in dFunc, or you can 
%  do it earlier on a trial-by-trial basis in D. Just make sure the 
%  smoothing/binning doesn't depend on the labels.

    dFunc = @(l) mean(D(:,l==1),2)-mean(D(:,l==2),2);
    
    S = 500; % the number of shuffles
    X_permute = zeros(T,S+1);

% the first difference is the unshuffled difference
    X_permute(:,1) = dFunc(L);

% shuffle
    for k = 2:S+1
        X_permute(:,k) = dFunc(L(randperm(N)));
    end
    [pvals,acceptPW,acceptSIM] = exchangeHT(X_permute,alpha,true);
    reject_null_idx(freq_idx,:) = pvals(:,6)

    reject_null_idx(freq_idx,pvals(:,6)>=alpha) = 1;
end
figure
imagesc(log10(reject_null_idx))

end

