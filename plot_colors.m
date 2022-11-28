function plot_colors(t,X,y)
colors = ['rb']
figure
hold on
for i = 1:size(X,1)
    plot(t,X(i,:), colors(y(i)+1))
end
end