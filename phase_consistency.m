function X_new = phase_consistency(X)
ph = phase_distribution(X)

y = sin(ph)
x = cos(ph)
r = sqrt(x.^2 + y.^2)
X_new = r
end