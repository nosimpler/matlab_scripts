function run_participant(t, X, Y, number)
[X_trunc,t] = truncate_data(X{number}, t, 0, 1)
[X_perm, y_perm] = permute_rows(X_trunc,Y{number})
X_filt = filter_beta(X_perm)
X_H = hilb_amp(X_filt)
plot_colors(t,X_H,y_perm)
plot_mean_timecourses(t,X_H,y_perm)
plot_nmf(X_H,y_perm)
end