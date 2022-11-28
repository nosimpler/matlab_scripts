function plot_grand_averages(t,X,y)
X_mean0 = mean(X(y==0,:),1)
X_mean1 = mean(X(y==1,:),1)

figure
hold on
plot(t, X_mean0, 'r')
plot(t, X_mean1, 'b')
legend('Non-detected', 'Detected')
hold off
l = line([1.025, 1.025], ylim(), 'LineWidth', 2, 'Color', [0.1, 0.1, 0.1])
%xlim([0.9, 1.1])
end