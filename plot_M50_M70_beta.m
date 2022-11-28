function plot_M50_M70_beta(X, y,t)



figure
% for i = 1:length(X)
%      % use equal number of detect nondetect trials
%      %[X_70, y_70] = get_equal_detect_nondetect(X{i},y{i}, 35, 'last')
%      % or use all trials (if prepartitioned equal detect/nondetect)
%      X_70 = X{i};
%      y_70 = y{i};
%      %restrict to 
%      X_70 = X_70(y_70 == 0, :);
%      trials_low = beta_percentiles(X_70, [0,0.5], 'hack', 'MEG');
%      trials_high = beta_percentiles(X_70, [0.5,1], 'hack', 'MEG');
%      X_beta = [X_70(trials_low,:); X_70(trials_high,:)];
%      y_beta = [zeros(length(trials_low),1); ones(length(trials_high),1)];
%      [slope, amplitude] = M50_M70(X_beta,t);
%      [p,h] = ranksum(amplitude(y_beta == 1), amplitude(y_beta == 0));
%      if h == 1
%          star = '*';
%      else
%          star = '';
%      end
%      subplot(4, 3, i)
%      hold on
% 	 h3 = histogram(amplitude(y_beta==1), 'BinWidth', 5e-9);
%      h4 = histogram(amplitude(y_beta==0), 'BinWidth', 5e-9);
%      h3.Normalization = 'probability';
%      h4.Normalization = 'probability';
%      title([num2str(i),star]);
%      xlabel('Am');
%      ylabel('Probability');
%      if i == length(X)
%          legend({'Low beta', 'High beta'});
%      end
% end
% suptitle('Peak-to-trough amplitude |M50-M70|');
% 
% figure
% trials_low = {};
% trials_high = {};
% for i = 1:length(X)
%     
%     % use equal number of high and low beta trials
%     %[X_70, y_70] = get_equal_detect_nondetect(X{i},y{i}, 35, 'last')
%      % or use all trials
%     X_70 = X{i};
%     y_70 = y{i};
%     X_70 = X_70(y_70 == 0, :);
%     trials_low{i} = beta_percentiles(X_70, [0,0.5], 'hack', 'MEG');
%     trials_high{i} = beta_percentiles(X_70, [0.5,1], 'hack', 'MEG');
%     X_beta = [X_70(trials_low{i},:); X_70(trials_high{i},:)];
%     
%     y_beta = [zeros(length(trials_low{i}),1); ones(length(trials_high{i}),1)];
%     
%     [slope, amplitude] = M50_M70(X_beta,t);
%     [p,h] = ranksum(slope(y_beta == 1), slope(y_beta == 0));
%     if h == 1
%         star = '*';
%     else
%         star = '';
%     end
%     subplot(4,3,i);
%     hold on
%     h1 = histogram(slope(y_beta==1), 'BinWidth', 2e-7);
%     h2 = histogram(slope(y_beta==0), 'BinWidth', 2e-7);
%     h1.Normalization = 'probability';
%     h2.Normalization = 'probability';
%     xlabel('Am/s');
%     ylabel('Probability');
%     title([num2str(i),star]);
%     if i == length(X)
%          legend({'Low beta', 'High beta'});
%     end
% end
suptitle('Average dipole velocity');
% for i = 1:10
%     X{i} = X{i}(y{i} == 1,:)
% end
[X_low, y_low] = beta_percentiles_subjectwise(X, y, [0, 0.5], 1:600, 600);
[X_high, y_high] = beta_percentiles_subjectwise(X, y, [0.5, 1], 1:600, 600);
%may introduce some subject overweighting

X_all = [X_low; X_high];

X_all = TVRD(X_all);
y_all = [zeros(size(X_low,1),1);ones(size(X_high,1),1)];
%[X_700, y_700] = get_equal_detect_nondetect(X_all,y_all, 350, 'random')
[slope, amplitude] = M50_M70(X_all,t);
figure;
subplot(2,1,1)
hold on;
h5 = histogram(amplitude(y_all==1), 'BinWidth', 5e-9);
h6 = histogram(amplitude(y_all==0), 'BinWidth', 5e-9);
h5.Normalization = 'probability';
h6.Normalization = 'probability';
xlabel('Am');
ylabel('Probability');
title('Peak-to-trough amplitude |M50-M70|');
legend({'Low beta', 'High beta'});
subplot(2,1,2);
hold on;
h7 = histogram(slope(y_all==1), 'BinWidth', 2e-7);
h8 = histogram(slope(y_all==0), 'BinWidth', 2e-7);
[p,h] = ranksum(slope(y_all == 1), slope(y_all == 0));
[p1,h1] = ranksum(amplitude(y_all == 1), amplitude(y_all == 0));
h7.Normalization = 'probability';
h8.Normalization = 'probability';
xlabel('Am/s');
ylabel('Probability');
title('Average dipole velocity');
legend({'Low beta', 'High beta'});
p
h
p1
h1

