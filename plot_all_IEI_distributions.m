%pass load_MEG_data, load_attention_data, etc.
%function IEIs = plot_all_IEI_distributions()
func_list = {@load_mouse_data, @load_MEG_data,  @load_attention_data}
directory = '/Users/rlaw/Desktop/2016-7-22/'
nbins = 50
labels = {'Mouse LFP', 'Human MEG', 'Human MEG'}
title_labels = {' (detection task)', ' (detection task)', ' (attention task)'} 
null_labels = {'Null mouse LFP','Null human MEG', 'Null human MEG'}
labels0 = {' Nondetected', ' Nondetected', ' Nonattended'}
labels1 = {' Detected', ' Detected', ' Attended'}

for i = 1:length(func_list)
    figure; hold on
    [X,y,t] = func_list{i}('prebp');
    [IEIs,y_IEIs] = agg_func(@find_IEIs, X, y);
    median_IEI = median(IEIs)
    [n_pks, y_pks] = agg_func(@count_peaks, X, y);
    null_IEIs = agg_func(@null_IEI_dist2,X, y);
    histogram(IEIs,nbins, 'DisplayName', labels{i}) %, 'support', [eps 1+eps]);
    histogram(null_IEIs, nbins, 'DisplayName', null_labels{i}) %, 'support', [eps 1+eps]);
    alpha(0.5)
    
    line([median_IEI, median_IEI], [-1, 9], 'LineWidth', 3, 'Color', 'k', 'alpha', 0.5)
    %plot(iei,p, 'LineWidth', 3, 'DisplayName', labels{i});
    %plot(iei0,p0, 'LineWidth', 3, 'DisplayName', null_labels{i});
    title(['Inter-event interval histogram', title_labels{i}])
    xlabel('Inter-event interval (s)')
    ylabel('Frequency')
    legend('show')
    saveas(gcf,[directory,func2str(func_list{i}),'nullIEI.pdf'])
end

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
  
    [IEIs1,y_IEIs1] = agg_func(@find_IEIs, X1, y1);
    [n_pks1, y_pks1] = agg_func(@count_peaks, X1, y1);
    %[p1, iei1] = ksdensity(IEIs1, 'support', [eps 1+eps]);
    %plot(iei1, p1, 'LineWidth', 3, 'DisplayName', [labels{i}, labels1{i}]);
    histogram(IEIs1,  nbins, 'DisplayName', [labels{i}, labels1{i}], 'Normalization', 'pdf');
    alpha(0.5)
    [IEIs0,y_IEIs0] = agg_func(@find_IEIs, X0, y0);
    [n_pks0, y_pks0] = agg_func(@count_peaks, X0, y0);
    %[p0, iei0] = ksdensity(IEIs0, 'support', [eps 1+eps]);
    %plot(iei0,p0, 'LineWidth', 3, 'DisplayName', [labels{i}, labels0{i}]);
    histogram(IEIs0, nbins, 'DisplayName', [labels{i}, labels0{i}], 'Normalization', 'pdf');
    alpha(0.5)
    null_IEIs = agg_func(@null_IEI_dist2,X, y);
    histogram(null_IEIs, nbins, 'DisplayName', [null_labels{i}], 'Normalization', 'pdf');
    alpha(0.5)
    legend('show');
    xlabel('Inter-event interval')
    ylabel('Probability density')
    saveas(gcf,[directory,func2str(func_list{i}),'IEI-hist.pdf'])
end

%compute distributions with subjectwise error bars


    