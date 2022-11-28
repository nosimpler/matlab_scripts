%pass load_MEG_data, load_attention_data, etc.
%function IEIs = plot_all_IEI_distributions()
func_list = {@load_mouse_data, @load_MEG_data,  @load_attention_data}
directory = '/Users/rlaw/Desktop/2016-7-22/'
nbins = 50
labels = {'Mouse LFP', 'Human MEG', 'Human MEG'}
null_labels = {'Null mouse LFP','Null human MEG', 'Null human MEG'}
labels0 = {' Nondetected', ' Nondetected', ' Nonattended'}
labels1 = {' Detected', ' Detected', ' Attended'}
figure; hold on
for i = 1:length(func_list)
    
    [X,y,t] = func_list{i}('prebp');
    [IEIs,y_IEIs] = agg_func(@find_event_times, X, y);
    [n_pks, y_pks] = agg_func(@count_peaks, X, y);
    null_IEIs = null_event_times_dist(n_pks, 1);
    [p, iei] = ksdensity(IEIs, 'support', [0 1+eps]);
    [p0, iei0] = ksdensity(null_IEIs, 'support', [0 1+eps]);
    plot(iei,p, 'LineWidth', 3, 'DisplayName', labels{i});
    plot(iei0,p0, 'LineWidth', 3, 'DisplayName', null_labels{i});
end
title('Kernel density estimate of event time distribution')
xlabel('Event time')
ylabel('Probability density')
legend('show')
saveas(gcf,[directory,'KDE-eventtime.pdf'])

for i = 1:length(func_list)
    figure; hold on
    [X,y,t] = func_list{i}('prebp');
    X0 = {};
    Y0 = {};
    X1 = {};
    Y1 = {};
    for j = 1:length(X)
        X0{j} = X{j}(:,:,y{j} == 0);
        y0{j} = y{j}(y{j}==0);
        X1{j} = X{j}(:,:,y{j} == 1);
        y1{j} = y{j}(y{j}==1);
    end
    [IEIs1,y_IEIs1] = agg_func(@find_event_times, X1, y1);
    [n_pks1, y_pks1] = agg_func(@count_peaks, X1, y1);
    %[p1, iei1] = ksdensity(IEIs1, 'support', [0 1+eps]);
    %plot(iei1, p1, 'LineWidth', 3, 'DisplayName', [labels{i}, labels1{i}]);
    histogram(IEIs1, nbins, 'DisplayName', [labels{i}, labels1{i}]);
    alpha(0.5)
    [IEIs0,y_IEIs0] = agg_func(@find_event_times, X0, y0);
    [n_pks0, y_pks0] = agg_func(@count_peaks, X0, y0);
    %[p0, iei0] = ksdensity(IEIs0, 'support', [0 1+eps]);
    %plot(iei0,p0, 'LineWidth', 3, 'DisplayName', [labels{i}, labels0{i}]);
    histogram(IEIs0, nbins, 'DisplayName', [labels{i}, labels0{i}]);
    alpha(0.5)
    xlabel('Event time')
    ylabel('Number of events')
    title('Event time histogram')
    legend('show')
    saveas(gcf,[directory,func2str(func_list{i}),'eventtime-hist.pdf'])
end
    