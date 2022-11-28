function plot_all_IEIs(IEI_MEG, IEI_MEG_null, IEI_mouse, IEI_mouse_null)
figure
hold on
[y_meg, x_meg] = ksdensity(IEI_MEG, 'support', [eps 1])
[y_meg0, x_meg0] = ksdensity(IEI_MEG_null, 'support', [eps 1])
[y_mouse, x_mouse] = ksdensity(IEI_mouse, 'support', [eps 1])
[y_mouse0, x_mouse0] = ksdensity(IEI_mouse_null, 'support', [eps 1])
labels = {'MEG', 'Mouse','MEG null', 'Mouse null'}
plot(x_meg, y_meg, 'LineWidth', 3)
plot(x_mouse, y_mouse, 'LineWidth', 3)
plot(x_meg0,y_meg0, 'LineWidth', 3)

plot(x_mouse0, y_mouse0, 'LineWidth', 3)
legend(labels)
end
