function X_new = c_rad(X)
p = phase_distribution(X);
x = mean(cos(p),1);
y = mean(sin(p),1);
X_new = sqrt(x.^2 + y.^2);
end