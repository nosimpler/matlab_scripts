function plot_raw_and_regularized(X,y,t)

n_trials = size(X,1);

regularized = TVRD(X);
detected = mean(regularized(y==1,:));
nondetected = mean(regularized(y==0,:));
detected_raw = mean(X(y==1,:))
nondetected_raw = mean(X(y==0,:))
figure;
hold on
yyaxis left
plot(t, detected, 'LineWidth', 3, 'DisplayName', 'Detected (regularized)', 'Color', 'b')
plot(t, nondetected, 'LineWidth', 3, 'DisplayName', 'Nondetected (regularized)', 'Color', 'r')

yyaxis right
plot(t, detected_raw, 'LineWidth', 1, 'Color', 'b', 'DisplayName', 'Detected (raw)')
plot(t, nondetected_raw, 'LineWidth', 1, 'Color', 'r', 'DisplayName', 'Nondetected (raw)')
title('Dipole moment (nAm)')
legend('show')
end