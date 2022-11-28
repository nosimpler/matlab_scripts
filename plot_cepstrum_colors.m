function plot_cepstrum_colors(t,X,y)
colors = ['rb']
figure
hold on
for i = 1:size(X,1)
    plot(t,power_cepstrum(X(i,:)), colors(y(i)+1))
end
end