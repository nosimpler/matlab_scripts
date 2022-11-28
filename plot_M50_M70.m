function plot_M50_M70(X, y,t)


figure
for i = 1:length(X)
     [slope, amplitude] = M50_M70(X{i},t)
     subplot(4, 3, i)
     hold on
	 h3 = histogram(amplitude(y{i}==1), 'BinWidth', 5e-9)
     h4 = histogram(amplitude(y{i}==0), 'BinWidth', 5e-9)
     h3.Normalization = 'probability'
     h4.Normalization = 'probability'
     title(num2str(i))
     xlabel('Am')
     ylabel('Probability')
end
suptitle('Peak-to-trough amplitude |M50-M70|')

figure
for i = 1:length(X)
    [slope, amplitude] = M50_M70(X{i},t)
    
    subplot(4,3,i)
    hold on
    h1 = histogram(slope(y{i}==1), 'BinWidth', 25e-7)
    h2 = histogram(slope(y{i}==0), 'BinWidth', 25e-7)
    h1.Normalization = 'probability'
    h2.Normalization = 'probability'
    xlabel('Am/s')
    ylabel('Probability')
    title(num2str(i))
end
suptitle('Average dipole velocity')

[X_all, y_all] = aggregate_data(X, y);
[slope, amplitude] = M50_M70(X_all,t)
figure;
subplot(2,1,1)
hold on
h5 = histogram(amplitude(y_all==1), 'BinWidth', 5e-9)
h6 = histogram(amplitude(y_all==0), 'BinWidth', 5e-9)
h5.Normalization = 'probability'
h6.Normalization = 'probability'
xlabel('Am')
ylabel('Probability')
title('Peak-to-trough amplitude |M50-M70|')
subplot(2,1,2)
hold on
h7 = histogram(slope(y_all==1), 'BinWidth', 25e-7)
h8 = histogram(slope(y_all==0), 'BinWidth', 25e-7)
h7.Normalization = 'probability'
h8.Normalization = 'probability'
xlabel('Am/s')
ylabel('Probability')
title('Average dipole velocity')
