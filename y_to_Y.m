%sets up target space as a set of orthogonal vectors
function Y = y_to_Y(y)
labels = unique(y);
Y = zeros(length(y), length(labels));
for i = 1:length(labels)
    Y(y==labels(i),i) = 1;
end
end