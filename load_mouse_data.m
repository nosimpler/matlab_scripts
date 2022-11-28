function [X, y, t] = load_mouse_data(datatype)
mouse_dir = '~/Desktop/mousedata/'
dir_list = dir(mouse_dir)
X = {}
y = {}
i = 1
for j = 1:length(dir_list)
    if dir_list(j).name(1) == 'b'
        f = dir_list(j).name
        obj = load([mouse_dir,f])
        
        if i == 1
            t = obj.rawtimeline
        end
        if strcmp(datatype, 'raw') == 1
            X{i} = obj.no_trial_S1_raw
            y{i} = zeros(size(obj.no_trial_S1_raw,1),1)
            X{i} = [X{i};obj.yes_trial_S1_raw]
            y{i} = [y{i};ones(size(obj.yes_trial_S1_raw,1),1)]
            %X{i} = X{i}(:,501:1500,:) prestimulus only
            X{i} = X{i}(:,501:1750,:)
        elseif strcmp(datatype, 'bp') == 1
            X{i} = obj.TFR_no
            y{i} = zeros(size(obj.TFR_no,3),1)
            X{i} = cat(3, X{i},obj.TFR_yes)
            y{i} = [y{i};ones(size(obj.TFR_yes,3),1)]
            X{i} = X{i}(:,501:1500,:)
        elseif strcmp(datatype, 'allTFR') == 1
            X{i} = obj.TFR_no
            y{i} = zeros(size(obj.TFR_no,3),1)
            X{i} = cat(3, X{i},obj.TFR_yes)
            y{i} = [y{i};ones(size(obj.TFR_yes,3),1)]
        elseif strcmp(datatype, 'last80') == 1
            X{i} = obj.no_trial_S1_raw(end-79:end,:)
            y{i} = zeros(size(obj.no_trial_S1_raw(end-79:end,:),1),1)
            X{i} = [X{i};obj.yes_trial_S1_raw(end-79:end,:)]
            y{i} = [y{i};ones(size(obj.yes_trial_S1_raw(end-79:end,:),1),1)]
            X{i} = X{i}(:,501:1750,:)
            %X{i} = X{i}(:,1:600,:)    
        elseif strcmp(datatype, 'prebp') == 1
            raw0 = obj.no_trial_S1_raw(:,1:1500);
            raw1 = obj.yes_trial_S1_raw(:,1:1500);
            TFR0 = get_TFRs(raw0,1:100,1000);
            TFR1 = get_TFRs(raw1,1:100,1000);
            X{i} = TFR0(:,501:1500,:);
            y{i} = zeros(size(TFR0,3),1);
            X{i} = cat(3,X{i},TFR1(:,501:1500,:));
            y{i} = [y{i};ones(size(TFR1,3),1)];
        end
        
        i = i + 1
    end
end
t = t(501:1750)
end