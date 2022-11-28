function  extreme_waveform(Xpre, Xpost, tpost)
Xpost = baseline_shift(Xpre, Xpost);
METHOD = 'mtm'
bounds_low = [0,0.1];
bounds_high = [0.9, 1];

trials_low = beta_percentiles(Xpre, bounds_low, METHOD);
trials_high = beta_percentiles(Xpre, bounds_high, METHOD);

X_low_mean = mean(Xpost(trials_low,:));
X_high_mean = mean(Xpost(trials_high,:));
X_low_std = std(Xpost(trials_low,:))/length(trials_low);
X_high_std = std(Xpost(trials_high,:))/length(trials_high);
figure; hold on
plot(tpost, -X_low_mean, 'LineWidth', 3, 'DisplayName', 'Low beta')
plot(tpost, -X_high_mean, 'LineWidth', 3, 'DisplayName', 'High beta')
legend('show')
xlabel('Time (s)')
ylabel('Dipole (Am)')
end