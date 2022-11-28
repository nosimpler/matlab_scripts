func_list = {@load_mouse_data, @load_MEG_data,  @load_attention_data}
for i = 1:length(func_list)
    
    [X,y,t] = func_list{i}('prebp');
    [n_events,y_ev] = agg_func(@count_overlapping_events, X, y);
    n_events_tot(i) = sum(n_events);
end

