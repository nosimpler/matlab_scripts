function plot_nmf(X,y)
[W,H] = nnmf(X, 3)
colors = ['rb']
figure
hold on
for i = 1:size(X,1)
    scatter3(W(i,1),W(i,2),W(i,3), colors(y(i)+1))
end
end