function plot_by_derivative(X,y,t)
sign = 1
n_trials = size(X,1);

slope = diff(sign*TVRD(X),1,2);
[pvals, acceptSIM, acceptPW] = exchange(slope', y, t)
size(pvals)
detected = mean(slope(y==1,:));
nondetected = mean(slope(y==0,:));
SIMlog = (pvals(:,6) < 0.05);
PWlog = (pvals(:,3) < 0.05);
figure;
hold on
[p1, p2] = TS_signif(detected, nondetected, t(1:length(detected)), SIMlog', PWlog')
legend([p1, p2], {'Detected', 'Nondetected'})
ylabel('Dipole velocity (Am/s)')
xlabel('Time (s)')
end