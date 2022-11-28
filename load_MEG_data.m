function [X,y,t] = load_MEG_data(datatype)

directory = '~/Dropbox/MEG-data-analysis/MEG'
dir_list = dir(directory)
X = {}
y = {}
i = 1
for j = 1:length(dir_list)
    if (dir_list(j).name(1) == '0') %&& ~strcmp(dir_list(j).name(1:6), '060327')
        trial_dir = dir_list(j).name
        
        obj = load([directory,'/',trial_dir, '/SI_TFR_raw.mat'])
        
        if i == 1
            t = obj.timeVec
        end
      
        if strcmp(datatype, 'raw') == 1
            X{i} = obj.no_trial_S1_raw
            y{i} = zeros(size(obj.no_trial_S1_raw,1),1)
            X{i} = [X{i};obj.yes_trial_S1_raw]
            y{i} = [y{i};ones(size(obj.yes_trial_S1_raw,1),1)]
            %X{i} = X{i}(:,1:600,:)
        elseif strcmp(datatype, 'last100') == 1
            X{i} = obj.no_trial_S1_raw(end-99:end,:)
            y{i} = zeros(size(obj.no_trial_S1_raw(end-99:end,:),1),1)
            X{i} = [X{i};obj.yes_trial_S1_raw(end-99:end,:)]
            y{i} = [y{i};ones(size(obj.yes_trial_S1_raw(end-99:end,:),1),1)]
            %X{i} = X{i}(:,1:600,:)
        elseif strcmp(datatype, 'bp') == 1
            X{i} = obj.TFR_no
            y{i} = zeros(size(obj.TFR_no,3),1)
            X{i} = cat(3,X{i},obj.TFR_yes)
            y{i} = [y{i};ones(size(obj.TFR_yes,3),1)]
            X{i} = X{i}(:,1:600,:)
        elseif strcmp(datatype, 'prebp') == 1
            raw0 = obj.no_trial_S1_raw((end-99):end,1:600);
            raw1 = obj.yes_trial_S1_raw((end-99):end,1:600);
            %raw0 = obj.no_trial_S1_raw(:,1:600);
            %raw1 = obj.yes_trial_S1_raw(:,1:600);
            TFR0 = get_TFRs(raw0,1:60,600);
            TFR1 = get_TFRs(raw1,1:60,600);
            X{i} = TFR0;
            y{i} = zeros(size(TFR0,3),1);
            X{i} = cat(3,X{i},TFR1);
            y{i} = [y{i};ones(size(TFR1,3),1)];
        elseif strcmp(datatype, 'all_TFR') == 1
            raw0 = obj.no_trial_S1_raw;
            raw1 = obj.yes_trial_S1_raw;
            %raw0 = obj.no_trial_S1_raw(:,1:600);
            %raw1 = obj.yes_trial_S1_raw(:,1:600);
            TFR0 = get_TFRs(raw0,1:60,600);
            TFR1 = get_TFRs(raw1,1:60,600);
            X{i} = TFR0;
            y{i} = zeros(size(TFR0,3),1);
            X{i} = cat(3,X{i},TFR1);
            y{i} = [y{i};ones(size(TFR1,3),1)];
             elseif strcmp(datatype, 'full_TFR') == 1
            raw0 = obj.no_trial_S1_raw((end-99):end,:);
            raw1 = obj.yes_trial_S1_raw((end-99):end,:);
            %raw0 = obj.no_trial_S1_raw(:,1:600);
            %raw1 = obj.yes_trial_S1_raw(:,1:600);
            TFR0 = get_TFRs(raw0,1:60,600);
            TFR1 = get_TFRs(raw1,1:60,600);
            X{i} = TFR0;
            y{i} = zeros(size(TFR0,3),1);
            X{i} = cat(3,X{i},TFR1);
            y{i} = [y{i};ones(size(TFR1,3),1)];
        end
    
        
        
        
        
        i = i + 1
    end
end
%t = t(1:600)

end