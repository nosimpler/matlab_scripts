function plot_mean_timecourses(t, X, y)
n0 = length(y(y==0))
n1 = length(y(y==1))
mean0 = mean(X(y==0,:),1);

mean1 = mean(X(y==1,:),1);
err0 = std(X(y==0,:),1)/sqrt(n0);
err1 = std(X(y==1,:),1)/sqrt(n1);
figure
hold on
plot(t, mean0, 'r', 'LineWidth', 3)
plot(t, mean1, 'b', 'LineWidth', 3)
%conf. interval (std. err. sucks!)
plot(t, mean0+err0, 'r', 'LineWidth', 0.5)
plot(t, mean0-err0, 'r', 'LineWidth', 0.5)
plot(t, mean1+err1, 'b', 'LineWidth', 0.5)
plot(t, mean1-err1, 'b', 'LineWidth', 0.5)
end