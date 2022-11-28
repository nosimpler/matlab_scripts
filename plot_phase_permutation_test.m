function plot_phase_permutation_test(f,X,y)
figure, hold on
p_thresh = 0.05
mean_diff_perm = []
n_perms = 200
subsample_for_plot = 50
for i = 1:n_perms
    i
    mean_diff_perm(i,:) = diff_rad(X,y);
    if mod(i,subsample_for_plot) == 0
        plot(f, mean_diff_perm(i,:), 'k', 'LineWidth', 0.5)
    end
end
mean0 = c_rad(X(y==0,:));
mean1 = c_rad(X(y==1,:));
mean_diff = mean1-mean0;
plot(f, mean_diff, 'LineWidth', 3)

conf = [];
conf_idx = [floor(0.5*p_thresh*n_perms), floor((1-0.5*p_thresh)*n_perms)]
for f_idx=1:length(f)
    perm_vals = sort(mean_diff_perm(:,f_idx));
    conf(:,f_idx) = perm_vals(conf_idx);
end
plot(f, conf(1,:), 'b')
plot(f, conf(2,:), 'b')
%line([1.025,1.025],ylim(), 'Color', 'r')
end