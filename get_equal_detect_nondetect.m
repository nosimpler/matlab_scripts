function [X_new, y_new] = get_equal_detect_nondetect(X, y, n, mode)
if strcmp(mode, 'random')
    y_new = []
    idx1 = find(y == 1)
    idx0 = find(y == 0)
    new_detect_idx = idx1(randperm(length(idx1)))
    new_nondetect_idx = idx0(randperm(length(idx0)))
    
    X_new_detect = X(new_detect_idx(1:n),:)
    X_new_nondetect = X(new_nondetect_idx(1:n),:)

    
elseif strcmp(mode, 'last')
    y_new = []
    idx1 = find(y == 1)
    idx0 = find(y == 0)
    X_new_detect = X(idx1(end-n+1:end),:)
    X_new_nondetect = X(idx0(end-n+1:end),:)
end
y_new(1:n) = 0
y_new(n+1:2*n) = 1
X_new = [X_new_nondetect; X_new_detect]
y_new = y_new'
end