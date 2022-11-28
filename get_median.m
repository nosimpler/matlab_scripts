function X_median = get_median(X)
X_new = []
sz = size(X);
len_f = sz(1);
len_data = prod(sz([2 3]));
%X_new = reshape(X, [len_f, len_data]);
for i = 1:sz(3)
    
    X_new = [X_new X(:,:,i)];

size(X_new);

X_median = median(X_new, 2);

end