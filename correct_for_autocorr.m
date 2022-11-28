function [gamma1, gamma2] = correct_for_autocorr(X, ACF)
n = size(X,2)
k = 1:(n-1)
gamma1 = 1-(2/(n-1)*sum((1-k/n).*ACF(k)))
gamma2 = 1+2*sum((1-k/n).*ACF(k))
end