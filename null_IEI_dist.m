function null_IEI = null_IEI_dist(n_pks, interval)
null_IEI = []
for i = 1:length(n_pks)
    if n_pks(i) > 1
        for pk = 1:n_pks
            
        event_times = sort(rand(1,n_pks(i))*interval);
        null_IEI = [null_IEI, diff(event_times)];
    end
    
end
null_IEI = null_IEI'
end