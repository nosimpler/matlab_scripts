function plot_detection_post(Xpre, Xpost, y, t)
%t is t_post
Xpost = baseline_shift(Xpre, X_post)
bounds_low = [0,0.1];
bounds_high = [0.9, 1];

trials_low = beta_percentiles(Xpre, bounds_low);
trials_high = beta_percentiles(Xpre, bounds_high);
y_low = y(trials_low)
y_high = y(trials_high)
X_low_mean = mean(Xpost(trials_low,:));
X_high_mean = mean(Xpost(trials_high,:));
X_low_std = std(Xpost(trials_low,:))/length(trials_low);
X_high_std = std(Xpost(trials_high,:))/length(trials_high);



high_detected = trials_high(y_high == 1)
high_nondetected = trials_high(y_high == 0)
low_detected = trials_low(y_low == 1)
low_nondetected = trials_low(y_low == 0)

figure;

subplot(2,1,1)
hold on
plot(t, mean(Xpost(high_detected, :)), 'DisplayName', 'Detected', 'LineWidth', 3)


plot(t, mean(Xpost(high_nondetected, :)), 'DisplayName', 'Nondetected', 'LineWidth', 3)
title('High beta')
legend('show')
subplot(2,1,2)
hold on
plot(t, mean(Xpost(low_detected, :)), 'LineWidth', 3)

plot(t, mean(Xpost(low_nondetected, :)), 'LineWidth', 3)
title('Low beta')
end