function X_new = get_TFRs(X, cfs, fs)
X_new = zeros(length(cfs),size(X,2),size(X,1));
for trial = 1:size(X,1)
    [TFR ,t, f] = traces2TFR(X(trial,:)',cfs, fs, 6);
    X_new(:,:, trial) = TFR;
end
end