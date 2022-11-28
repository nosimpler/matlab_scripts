function [p1, p2] = TS_signif(signal1, signal2, t, SIMlog, PWlog)

PWcolor = 'y'
SIMcolor = [0.05 0.7 0.05]



regionsSIM = logical2regions(SIMlog)
regionsPW = logical2regions(PWlog)
hold on
p1 = plot(t, signal1, 'LineWidth', 3)
p2 = plot(t, signal2, 'LineWidth', 3)
yl = ylim()
for region_idx = 1:size(regionsSIM,1)
    x1 = t(regionsSIM(region_idx,1))
    x2 = t(regionsSIM(region_idx,2))
    fill([x1 x2 x2 x1], [yl(1) yl(1), yl(2), yl(2)], SIMcolor, ...
    'EdgeColor','none', 'FaceAlpha', 0.2);
end

for region_idx = 1:size(regionsPW,1)
    x1 = t(regionsPW(region_idx,1))
    x2 = t(regionsPW(region_idx,2))
    fill([x1 x2 x2 x1], [yl(1) yl(1), yl(2), yl(2)], PWcolor, ...
    'EdgeColor','none', 'FaceAlpha', 0.22);
end
uistack(p1, 'top')
uistack(p2, 'top')

end