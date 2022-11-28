function plot_mean_autocorr(X,y)
colors = ['rb']

n0 = length(y(y==0))
n1 = length(y(y==1))
X_aut = []
for i = 1:size(X,1)
    [X_aut(i,:), lag] = xcorr(X(i,:));
    %plot(lag/600,acorr, colors(y(i)+1));
end
lag = lag/600
acorr0 = mean(X_aut(y==0,:),1);
acorr1 = mean(X_aut(y==1,:),1);

err0 = std(X_aut(y==0,:),1)/sqrt(n0);
err1 = std(X_aut(y==1,:),1)/sqrt(n1);
figure
hold on
plot(lag, acorr0, 'r', 'LineWidth', 3)
plot(lag, acorr1, 'b', 'LineWidth', 3)
%conf. interval (std. err. sucks but whatever)
plot(lag, acorr0+err0, 'r', 'LineWidth', 0.5)
plot(lag, acorr0-err0, 'r', 'LineWidth', 0.5)
plot(lag, acorr0+err1, 'b', 'LineWidth', 0.5)
plot(lag, acorr0-err1, 'b', 'LineWidth', 0.5)

end