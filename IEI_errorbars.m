%function IEI_errorbars(X,y)
func_list = {@load_mouse_data, @load_MEG_data,  @load_attention_data}
%func_list = {@load_MEG_data}
directory = '/Users/rlaw/Desktop/IEI-figs/'
labels = {'Mouse LFP', 'Human MEG', 'Human MEG'}
title_labels = {' (detection task)', ' (detection task)', ' (attention task)'} 
null_labels = {'Null mouse LFP','Null human MEG', 'Null human MEG'}
labels0 = {' Not detected', ' Not detected', ' Not attended'}
labels1 = {' Detected', ' Detected', ' Attended'}
hist_subj0 = []
hist_subj1 = []
hist_null = []
edges = []
for i = 1:length(func_list)
    figure; hold on
    [X,y,t] = func_list{i}('prebp');
    X0 = [];
    Y0 = [];
    X1 = [];
    Y1 = [];
    for j = 1:length(X)
        X0{j} = X{j}(:,:,y{j} == 0);
        y0{j} = y{j}(y{j}==0);
        X1{j} = X{j}(:,:,y{j} == 1);
        y1{j} = y{j}(y{j}==1);
    end
    [hist_subj0, edges] = subjectwise_hist(@find_IEIs, X0)
    [hist_subj1, edges] = subjectwise_hist(@find_IEIs, X1)
    
    %[hist_null0, edges] = subjectwise_hist(@null_IEI_dist2, X0)
    %[hist_null1, edges] = subjectwise_hist(@null_IEI_dist2, X1)
    %hist_null = (hist_null0 + hist_null1)/2
    H0 = shadedErrorBar(edges,hist_subj0', {@mean, @std}, 'r-',1);
    H1 = shadedErrorBar(edges,hist_subj1', {@mean, @std}, 'b-',1);
    %Hnull = shadedErrorBar(edges,hist_null', {@mean, @std}, 'k-',1);
    title([labels{i}, title_labels{i}], 'fontsize', 18)
    xlabel('Inter-event interval (s)', 'fontsize', 18)
    ylabel('Frequency', 'fontsize', 18)
    set(gca, 'XTick', [0, 0.25, 0.5, 0.75, 1])
    set(gca, 'FontSize', 14)
    
    %saveas(gcf,[directory,func2str(func_list{i}),'nullIEI_nice.pdf'])
    %legend([H1.mainLine, H0.mainLine, Hnull.mainLine], {labels1{i}, labels0{i}, 'null'}) 
end
