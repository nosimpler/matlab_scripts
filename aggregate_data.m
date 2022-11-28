function [X_new,y_new] = aggregate_data(X, y)
X_new = []
y_new = []
if length(size(X{1})) == 2 
    for i = 1:length(X)
        X_new = [X_new;X{i}];
        y_new = [y_new;y{i}];
    end
elseif length(size(X{1})) == 3
    for i = 1:length(X);
        X_new = cat(3, X_new, X{i});
        y_new = [y_new; y{i}];
    end
end
end