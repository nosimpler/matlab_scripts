function [X, y, t] = load_attention_data(datatype)
attn_dir = '~/Dropbox/MEG-data-analysis/MEG/attention_data_2010'
dir_list = dir(attn_dir)
X = {}
y = {}
i = 1

for j = 1:length(dir_list)
    strfind(dir_list(j).name, '125')
    if isempty(strfind(dir_list(j).name, '125'))
        if dir_list(j).name(1) == 'S' || dir_list(j).name(1) ==  's'
            
            trial_dir = dir_list(j).name
            prefix = ['s', dir_list(j).name(2:end)]
            if (strcmp(datatype, 'prebp') ==1) || ...
                    (strcmp(datatype, 'raw') == 1)
                suffix = '_A_triggers_attention_raw_prestim.mat'
            else
                suffix = '_A_attention_TFR_prestim.mat'
            end
            %prefix = [attn_dir,'/',trial_dir]
            obj = load([attn_dir,'/',trial_dir,'/', prefix, suffix])
            if i == 1
                t = obj.tVec
            end
            %         if strcmp(datatype, 'raw') == 1
            %             X{i} = obj.no_trial_S1_raw
            %             y{i} = zeros(size(obj.no_trial_S1_raw,1),1)
            %             X{i} = [X{i};obj.yes_trial_S1_raw]
            %             y{i} = [y{i};ones(size(obj.yes_trial_S1_raw,1),1)]
            if strcmp(datatype, 'bp') == 1
                
                
                X{i} = obj.TFR_afoot_prestim_mat;
                y{i} = zeros(size(obj.TFR_afoot_prestim_mat,3),1);
                X{i} = cat(3,X{i},obj.TFR_ahand_prestim_mat);
                y{i} = [y{i};ones(size(obj.TFR_ahand_prestim_mat,3),1)];
                X{i} = X{i}(:,601:1200,:);
            elseif strcmp(datatype, 'prebp') == 1
                
                raw0 = obj.S1dipole_trig_afoot((end-99):end,1:1200);
                raw1 = obj.S1dipole_trig_ahand((end-99):end,1:1200);
                TFR0 = get_TFRs(raw0,1:60,600);
                TFR1 = get_TFRs(raw1,1:60,600);
                X{i} = TFR0(:,601:1200,:);
                y{i} = zeros(size(TFR0,3),1);
                X{i} = cat(3,X{i},TFR1(:,601:1200,:));
                y{i} = [y{i};ones(size(TFR1,3),1)];
            elseif strcmp(datatype, 'all_TFR')

                TFR0 = obj.TFR_afoot_prestim_mat;
                TFR1 = obj.TFR_ahand_prestim_mat;
                X{i} = TFR0
                y{i} = zeros(size(TFR0,3),1);
                X{i} = cat(3,X{i},obj.TFR_ahand_prestim_mat);
                y{i} = [y{i};ones(size(TFR1,3),1)];
            elseif strcmp(datatype, 'raw')
                     
                
                raw0 = obj.S1dipole_trig_afoot;
                raw1 = obj.S1dipole_trig_ahand;
                X{i} = raw0;
                y{i} = zeros(size(raw0,1),1);
                X{i} = [X{i};raw1];
                y{i} = [y{i};ones(size(raw1,1),1)];
            i = i + 1
        end
    end
    end

end