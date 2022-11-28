function exchange_TFR_all(X, y, t, stim_idx, datatype)
if strcmp(datatype, 'MEG')
    xmin = 0
    xmax = 2100
    ymin = 0
    ymax = 60
    ticks = linspace(0, 2100, 8)
    ticklabels = (ticks - 600)*1000/600
end
if strcmp(datatype, 'attention')
    xmin = 0
    xmax = 2100
    ymin = 0
    ymax = 40
    ticks = linspace(0, 2100, 8)
    ticklabels = (ticks - 1200)*1000/600
end


for i = 1:length(X)
    figure; hold on
    plot_exchange_all_bands(X{i}, y{i}, t)
    %yl = ylim(); ymin = yl(1), ymax = yl(2)
    plot([stim_idx, stim_idx], [ymin, ymax], 'LineWidth', 1, 'Color', [0.5 0.5 0.5])
    xticks(ticks)
    xticklabels(ticklabels)
    xlim([xmin, xmax])
    ylim([ymin, ymax])
    xlabel('Peristimulus time (ms)')
    ylabel('Frequency (Hz)')
    title([{['Subject ', num2str(i)]}, {'Time-frequency significant differences (pointwise)'}])
    print(['/Users/rlaw/Desktop/rob_beta_paper/attention_task/TFRs/subject_', num2str(i),'_sigdiffregions_pw.pdf'], '-dpdf')
end