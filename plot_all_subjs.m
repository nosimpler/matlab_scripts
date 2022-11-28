%pass load_MEG_data, load_attention_data, etc.
%function IEIs = plot_all_IEI_distributions()
func_list = {@load_mouse_data, @load_MEG_data,  @load_attention_data}
labels = {'Mouse LFP', 'Human MEG', 'Human MEG'}
feature_labels = {'Event length', 'Event time', 'Inter-event interval'}
null_labels = {'Null mouse LFP','Null human MEG', 'Null human MEG'}
labels0 = {' Nondetected', ' Nondetected', ' Nonattended'}
labels1 = {' Detected', ' Detected', ' Attended'}
SUPP = [eps, 1-eps]
feature_list = {@find_event_lengths, @find_event_times, @find_IEIs}
directory = '/Users/rlaw/Desktop/2016-7-22/'
for k = 1:length(feature_list)
    feature = feature_list{k}
    
    for i = 1:length(func_list)
        dataset = func2str(func_list{i})
        [X,y,t] = func_list{i}('prebp');
        X0 = {}
        Y0 = {}
        X1 = {}
        Y1 = {}
        if strcmp(func2str(func_list{i}),'load_attention_data')
            n_cols = 6
        else
            n_cols = 5
        end
        figure
        for j = 1:length(X)
            X0{j} = X{j}(:,:,y{j} == 0);
            y0{j} = y{j}(y{j}==0);
            X1{j} = X{j}(:,:,y{j} == 1);
            y1{j} = y{j}(y{j}==1);
            subplot(2,n_cols,j)
            
            hold on
            title(num2str(j))
            lengths1 = feature(X1{j});
            %[n_pks, y_pks] = count_peaks(X1{j})
            lengths0 = feature(X0{j});
            
            %[p, iei] = ksdensity(lengths1, 'support', SUPP);
            %[p0, iei0] = ksdensity(lengths0, 'support', SUPP);
            %plot(iei0,p0, 'LineWidth', 3);
            %plot(iei,p, 'LineWidth', 3);
            histogram(lengths1, 50, 'DisplayName', labels1{i})
            histogram(lengths0, 50, 'DisplayName', labels0{i})
            if j == 1
                xlabel(feature_labels{k})
                ylabel('Number')
                legend('show')
            end
            hold off
            %
        end
        saveas(gcf,[directory,func2str(feature), dataset,'.pdf'])
        %     [IEIs0,y_IEIs0] = agg_func(@find_event_lengths, X0, y0)
        %     [n_pks0, y_pks0] = agg_func(@count_peaks, X0, y0)
        %     [p0, iei0] = ksdensity(IEIs0, 'support', [0 1+eps])
        %     plot(iei0,p0, 'LineWidth', 3, 'DisplayName', [labels{i}, labels0{i}])
        %     [IEIs1,y_IEIs1] = agg_func(@find_event_lengths, X1, y1)
        %     [n_pks1, y_pks1] = agg_func(@count_peaks, X1, y1)
        %     [p1, iei1] = ksdensity(IEIs1, 'support', [0 1+eps])
        %     plot(iei1, p1, 'LineWidth', 3, 'DisplayName', [labels{i}, labels1{i}])
        %     legend('show')
    end
end
