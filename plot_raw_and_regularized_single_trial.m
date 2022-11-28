function plot_raw_and_regularized_single_trial(X, t)


regularized = TVRD(X);
%regularized(:,end) = []
figure; hold on
yyaxis left
plot(t, X, 'LineWidth', 1, 'Color', 'b', 'DisplayName', 'Unregularized')
yyaxis right
plot(t, regularized(1:end), 'LineWidth', 1, 'Color', 'r', 'DisplayName', 'Regularized')
title('Dipole moment (nAm)')
legend('show')
end