function plot_means(Xpre,Xpost, y, t)
sign = -1
ALPHA = 0.05
if ~isempty(Xpre)
    Xpost = baseline_shift(Xpre, Xpost)
end
figure; hold on



x1 = sign*mean(Xpost(y==1,:))
x2 = sign*mean(Xpost(y==0,:))
[pvals, acceptPW, acceptSIM] = exchange(Xpost', y, t)
SIMlog = pvals(:,6) < ALPHA
PWlog = pvals(:,3) < ALPHA
[p1, p2] = TS_signif(x1, x2, t, SIMlog', PWlog')
title('Predict Detection | Poststimulus waveform')
xlabel('Poststimulus time (ms)')
legend([p1, p2], {'Detected', 'Nondetected'})
end