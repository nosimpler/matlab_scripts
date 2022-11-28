function [pvals_low, pvals_high] = exchange_beta_sort(Xpre, Xpost, y, t)

bounds_low = [0,0.3];
bounds_high = [0.7,1];

trials_low = beta_percentiles(Xpre, bounds_low);
trials_high = beta_percentiles(Xpre, bounds_high);

[pvals_low, acceptPW_low, acceptSIM_low] = exchange(Xpost(trials_low,:)', y(trials_low), t)
[pvals_high, acceptPW_high, acceptSIM_high] = exchange(Xpost(trials_low,:)', y(trials_low), t)
end