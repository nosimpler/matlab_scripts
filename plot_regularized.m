function plot_regularized(X,y,t)

n_trials = size(X,1);

regularized = TVRD(X);
detected = -mean(regularized(y==1,:));
nondetected = -mean(regularized(y==0,:));
[pvals, acceptSIM, acceptPW] = exchange(regularized', y, t)
figure;
hold on
plot(t, detected, 'LineWidth', 2, 'DisplayName', 'Detected')
plot(t, nondetected, 'LineWidth', 2, 'DisplayName', 'Nondetected')
significant = pvals(:,6) <= 0.05;
significantPW = pvals(:,3) <= 0.05;
shading = zeros(size(detected))
shadingPW = zeros(size(detected))
yl = ylim()
shading(significant) = yl(2)*500
shading(~significant) = yl(1)
shadingPW(significantPW) = yl(2)*500
shadingPW(~significantPW) = yl(1)
Xcorners = [t, flipud(t)]
Ycorners = [shading, yl(1)*ones(size(shading))]
YcornersPW = [shadingPW, yl(1)*ones(size(shadingPW))]
fill(Xcorners, Ycorners, 'm', 'FaceAlpha', 0.2, 'EdgeAlpha', 0, 'DisplayName', 'Simultaneous')
fill(Xcorners, YcornersPW, 'y', 'FaceAlpha', 0.2, 'EdgeAlpha', 0, 'DisplayName', 'Pointwise')
ylim(yl)

title('Regularized dipole moment (nAm)')
legend('show')

figure;
plot(t(1:length(detected)), pvals(:,6))
title({'Exchangeability hypothesis test p-values';' (Simultaneous; alpha = 0.05)'})
xlabel('Time (s)')
ylabel('p')
legend('show')

figure;
plot(t(1:length(detected)), pvals(:,3))
title({'Exchangeability hypothesis test p-values';' (Pointwise; alpha = 0.05)'})
xlabel('Time (s)')
ylabel('p')
legend('show')
end