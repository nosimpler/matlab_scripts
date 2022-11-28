function plot_exchange_by_subject(X,y,t)
for i = 1:length(X)
    exchange(X{i}, y{i}, t)
end
end