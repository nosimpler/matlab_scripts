function null_IEIs = place_nonoverlap(event_lengths, interval, max_shift)

n_events = length(event_lengths);
%2:end if not using first event. 1:end if using first event
event_lengths_edgeless = event_lengths(1:end);
perm = randperm(n_events)
reordering = event_lengths_edgeless(perm);
max_shift = max_shift(perm)

event_cover = sum(reordering);
space = interval - event_cover %- first_event_end % + max_tail;
parts = diff([0 sort(rand(1, n_events)*space)]);
ends = cumsum(reordering + parts);
events = ends - max_shift
null_IEIs = diff(events)
