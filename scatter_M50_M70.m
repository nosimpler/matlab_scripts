function scatter_M50_M70(X, y, t)

M50_interval = [1000, 1060]*1e-3;
M70_interval = [1060, 1100]*1e-3;
n_trials = size(X,2);
n_t = size(X, 1);
X = TVRD(X)
M50_indices = find(t>M50_interval(1) & t<M50_interval(2));
M70_indices = find(t>M70_interval(1) & t<M70_interval(2));

%find maximum between 10 and 60ms
M50_val = [];
M50_idx = [];
M70_val = [];
M70_idx = [];
%min/max are switched because waveform is upside down
for i = 1:n_trials
    [M50_val, M50_idx] = min(X(:, M50_indices)');
    [M70_val, M70_idx] = max(X(:, M70_indices)');
end

M50_time = t(M50_idx+M50_indices(1)-1);
M70_time = t(M70_idx+M70_indices(1)-1);
figure; hold on
scatter(M50_time(y==1), M70_time(y==1))
scatter(M50_time(y==0), M70_time(y==0))
figure; hold on
histogram(M50_time(y==1)) 
histogram(M50_time(y==0))
end
%find minimum between 50 and 100ms