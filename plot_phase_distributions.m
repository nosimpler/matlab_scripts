function plot_phase_distributions(X,y)
ph0 = phase_distribution(X(y==0,:))
ph1 = phase_distribution(X(y==1,:))
figure; hold on
for ph_idx = 1:size(ph0, 2)
    rose(ph0(:,ph_idx))
end
figure; hold on
for ph_idx = 1:size(ph1, 1)
    rose(ph1(:,ph_idx)) 
end
    