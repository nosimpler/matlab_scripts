function plot_autocorr(X,y)
colors = ['rb']
figure
hold on
for i = 1:size(X,1)
    [acorr, lag] = xcorr(X(i,:));
    plot(lag/600,acorr, colors(y(i)+1));
end
end