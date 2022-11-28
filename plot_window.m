function plot_window(X,y,t,t_min, t_max)
X0 = mean(X(y==0,:),1)
X1 = mean(X(y==1,:),1)
figure
hold on
plot_idx = (t>t_min & t< t_max)
plot(t(plot_idx),X1(plot_idx), 'LineWidth', 3, 'DisplayName', 'Mean detected')
plot(t(plot_idx),X0(plot_idx), 'LineWidth', 3, 'DisplayName', 'Mean nondetected')
legend('show')
end