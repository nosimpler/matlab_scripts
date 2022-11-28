function scatter_labeled(X, Y, y)
figure; hold on
y_i = unique(y)
for i = 1:length(y_i)
    scatter(X(y == y_i(i)),Y(y == y_i(i)))
end
end