function plot_all_phase_dist(X,y,t)
for i= 1:length(X)
    [xi,ti] = truncate_data(X{i},t, 0,1.025)
    plot_phase_distributions(xi,y{i})
end