function [r0,r1] = phase_stats(X,y)
ph0 = phase_distribution(X(y==0,:))
n0 = length(y==0)
n1 = length(y==1)
ph1 = phase_distribution(X(y==1,:))
y_ph0 = sum(sin(ph0))/n0
x_ph0 = sum(cos(ph0))/n0
y_ph1 = sum(sin(ph1))/n1
x_ph1 = sum(cos(ph1))/n1

r0 = sqrt(y_ph0.^2+x_ph0.^2)
r1 = sqrt(y_ph1.^2+x_ph1.^2)
end
