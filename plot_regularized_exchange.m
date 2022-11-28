function plot_regularized_exchange(X,y,t)

n_trials = size(X,1);

TV = TVRD(X);
%TV(:,end) = []
[pvals, acceptSIM, acceptPW] = exchange(TV', y, t)
detected = mean(TV(y==1,:));
nondetected = mean(TV(y==0,:));

figure;
hold on
plot(t, detected, 'DisplayName', 'Detected')
plot(t, nondetected, 'DisplayName', 'Nondetected')
title('Regularized dipole moment (nAm/s)')
legend()

figure;
plot(pvals(:,6))
end