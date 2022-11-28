function plot_permutation_test(t,X,y)
figure, hold on
p_thresh = 0.005
mean_diff_perm = []
n_perms = 2000
subsample_for_plot = 100
for i = 1:n_perms
    i
    mean_diff_perm(i,:) = permuted_mean_diff(X,y);
    if mod(i,subsample_for_plot) == 0
        plot(t, mean_diff_perm(i,:), 'k', 'LineWidth', 0.5)
    end
end
mean0 = mean(X(y==0,:));
mean1 = mean(X(y==1,:));
mean_diff = mean1-mean0;
plot(t, mean_diff, 'LineWidth', 3)

conf = [];
conf_idx = [floor(0.5*p_thresh*n_perms), floor((1-0.5*p_thresh)*n_perms)]
for t_idx=1:length(t)
    perm_vals = sort(mean_diff_perm(:,t_idx));
    conf(:,t_idx) = perm_vals(conf_idx);
end
plot(t, conf(1,:), 'b')
plot(t, conf(2,:), 'b')
line([1.025,1.025],ylim(), 'Color', 'r')
end