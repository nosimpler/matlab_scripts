function event_times = null_event_times_dist(n_pks, interval)
event_times= []
for i = 1:length(n_pks)
    if n_pks(i) > 1
        event_times = [event_times sort(rand(1,n_pks(i))*interval)];
      
    end
    
end
event_times = event_times';
end