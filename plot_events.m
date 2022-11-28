function plot_events(times, events)
figure; hold on;
for i = 1:length(events)
    
    plot(times{i}, events{i})
end
end