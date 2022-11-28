function [pvals, acceptPW, acceptSIM] = exchange_viz(X,y,t)
X = X;
y = y;
t = t;
viz = 1
% ------------------------------------------------------------------------
% create some fake data --------------------------------------------------
% ------------------------------------------------------------------------

% Replace this section with loading your own data.
% The data D should be a TxN matrix of N trials and T time points per trial.
% The labels L should be a 1xN vector of 1's and 2's indicating the trial
%  type.

% create labels
N = size(X,2);
L = y+1;
T = size(X,1)
% create means for each label
D = X;

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
%dFunc = @(l) median(D(:,l==1),2)-median(D(:,l==2),2);
% ------------------------------------------------------------------------
% shuffle the labels and compute differences -----------------------------
% ------------------------------------------------------------------------

% You don't need to change anything here except the number of shuffles S.

S = 5000; % the number of shuffles
X = zeros(T,S+1);

% the first difference is the unshuffled difference
X(:,1) = dFunc(L);

% shuffle
for k = 2:S+1
    X(:,k) = dFunc(L(randperm(N)));
end

% ------------------------------------------------------------------------
% create the p-values and the acceptance bands ---------------------------
% ------------------------------------------------------------------------

% You don't need to change anything here except the significance level
% alpha.

alpha = 0.05; 
sflag = true; % use standardization (it's best to use this)

[pvals,acceptPW,acceptSIM] = exchangeHT(X,alpha,sflag);



% ------------------------------------------------------------------------
% visualization ----------------------------------------------------------
% ------------------------------------------------------------------------
if viz == 1

t = ((1:T)/T).';

subplot(2,2,1)
plot(t,D(:,L==1),'k-')
hold on, plot(t,mean(D(:,L==1),2),'r-','linewidth',3), hold off
title('type 1 trials with the mean in red')

subplot(2,2,2)
plot(t,D(:,L==2),'k-')
hold on, plot(t,mean(D(:,L==2),2),'b-','linewidth',3), hold off
title('type 2 trials with the mean in blue')

subplot(2,2,3)
plot(t,X,'k-')
hold on, plot(t,X(:,1),'color',[1 0 1],'linewidth',3), hold off
title({'mean difference (purple)','shuffled differences (black)'})

subplot(2,2,4)
fill([t;flipud(t)],[acceptSIM(:,1);flipud(acceptSIM(:,2))],[.85 .85 .85],'linestyle','none')
hold on, fill([t;flipud(t)],[acceptPW(:,1);flipud(acceptPW(:,2))],[.7 .7 .7],'linestyle','none')
hold on, plot(t,X(:,1),'color',[1 0 1]), hold off
title({'mean difference (purple)',[num2str((1-alpha)*100) '%% pointwise acceptance bands (dark grey)'], ...
    [num2str((1-alpha)*100) '%% simultaneous acceptance bands (light grey)']})
end
end





