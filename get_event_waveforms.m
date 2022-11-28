%input is array of indices bounding events, the peak index, the trials to which they
%correspond, and a raw data file
%this function associates the event time interval with the corresponding
%raw waveform

function [event_times, event_waveforms] = get_event_waveforms(event_idx, max_idx, trial, rawdata)
T = 1.0;
CENTERED = 0;
event_waveforms = {};
event_times = {};
n_timepoints = size(rawdata, 2);
t = linspace(0, T, n_timepoints);
for i = 1:length(trial)
    start_idx = event_idx{i}(1);
    end_idx = event_idx{i}(2);
    event_waveforms{i} = rawdata(trial{i}, start_idx:end_idx);
    event_times{i} = t(start_idx:end_idx);
    if CENTERED == 1
        event_times{i} = event_times{i} - t(max_idx{i});
    end
end
end