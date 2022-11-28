% sends an ordered list of booleans to a list of
% boundary indices
function regions = logical2regions(x)

size(x)
if size(x, 2) == 1
    x = x';
end
padded_x = [0, x, 0];

starts = diff(padded_x) == 1;
ends = diff(padded_x) == -1;

start_idx = find(starts(1:end-1))
end_idx = find(ends(2:end))
if end_idx
    if end_idx(end, end) > length(x)
        end_idx(end, end) = length(x);
    end
elseif isempty(end_idx) && ~isempty(start_idx)
    end_idx(length(end_idx)+1) = length(x)
elseif isempty(end_idx) && isempty(start_idx)
    regions = []
    return 
end
    

regions = [start_idx; end_idx]';

end