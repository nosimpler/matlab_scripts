function [slope,amplitude] = M50_M70(X, t)

M50_interval = [1020, 1060]*1e-3;
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

slope = -(M70_val - M50_val)./(M70_time - M50_time);
amplitude = abs(M50_val-M70_val);
end
%find minimum between 50 and 100ms