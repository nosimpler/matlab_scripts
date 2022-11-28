function X_post_new = baseline_shift(X_pre, X_post)
baseline = mean(X_pre, 2);
size(baseline);
onesshift = ones(1,size(X_post,2));
size(onesshift);
shift = baseline*onesshift;
size(shift);
X_post_new = X_post - shift;
end