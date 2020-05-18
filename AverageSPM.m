function [] = AverageSPM(datas, dataLabelss)

    avg_steps_x_w = [];
    avg_steps_x_wu = [];
    avg_steps_x_wd = [];
    avg_steps_y_w = [];
    avg_steps_y_wu = [];
    avg_steps_y_wd = [];
    avg_steps_z_w = [];
    avg_steps_z_wu = [];
    avg_steps_z_wd = [];
    
    for j=1:numel(datas)
        %disp("DATA " + (50+j));
        data = cell2mat(datas(j));
        dataLabels = cell2mat(dataLabelss(j));

        steps_x_w = [];
        steps_x_wu = [];
        steps_x_wd = [];
        steps_y_w = [];
        steps_y_wu = [];
        steps_y_wd = [];
        steps_z_w = [];
        steps_z_wu = [];
        steps_z_wd = [];

        for i = 1:length(dataLabels)
            start = dataLabels(i, 4);
            finish = dataLabels(i, 5);
            data_steps = data(dataLabels(i, 4):dataLabels(i, 5), :);
            switch dataLabels(i, 3)
                case 1
                   [signal_steps_x, signal_steps_y, signal_steps_z] = dynamicActivitiesDFT(data_steps); 
                   size = dataLabels(i, 5) - dataLabels(i, 4);
                   [steps_x, steps_y, steps_z] = stepsPerMinute(signal_steps_x, signal_steps_y, signal_steps_z, size);
                   steps_x_w = horzcat(steps_x_w, steps_x);
                   steps_y_w = horzcat(steps_y_w, steps_y);
                   steps_z_w = horzcat(steps_z_w, steps_z);
                case 2
                   [signal_steps_x, signal_steps_y, signal_steps_z] = dynamicActivitiesDFT(data_steps); 
                   size = dataLabels(i, 5) - dataLabels(i, 4);
                   [steps_x, steps_y, steps_z] = stepsPerMinute(signal_steps_x, signal_steps_y, signal_steps_z, size);
                   steps_x_wu = horzcat(steps_x_wu, steps_x);
                   steps_y_wu = horzcat(steps_y_wu, steps_y);
                   steps_z_wu = horzcat(steps_z_wu, steps_z);
                case 3
                   [signal_steps_x, signal_steps_y, signal_steps_z] = dynamicActivitiesDFT(data_steps); 
                   size = dataLabels(i, 5) - dataLabels(i, 4);
                   [steps_x, steps_y, steps_z] = stepsPerMinute(signal_steps_x, signal_steps_y, signal_steps_z, size);
                   steps_x_wd = horzcat(steps_x_wd, steps_x);
                   steps_y_wd = horzcat(steps_y_wd, steps_y);
                   steps_z_wd = horzcat(steps_z_wd, steps_z);
            end
        end

        %stft(data51(:,3));

        %media e desvio padrao
        %walking


        mean_walking_x = mean(steps_x_w);
        mean_walking_y = mean(steps_y_w);
        mean_walking_z = mean(steps_z_w);
%         disp("Walking X - media: " + mean_walking_x);
%         disp("Walking Y - media: " + mean_walking_y);
%         disp("Walking Z - media: " + mean_walking_z);
% 
%         std_walking_x = std(steps_x_w);
%         std_walking_y = std(steps_y_w);
%         std_walking_z = std(steps_z_w);
%         disp("Walking X - desvio padrao: " + std_walking_x);
%         disp("Walking Y - desvio padrao: " + std_walking_y);
%         disp("Walking Z - desvio padrao: " + std_walking_z);

        %walking up

        mean_walkingUp_x = mean(steps_x_wu);
        mean_walkingUp_y = mean(steps_y_wu);
        mean_walkingUp_z = mean(steps_z_wu);
%         disp("WalkingUp X - media: " + mean_walkingUp_x);
%         disp("WalkingUp Y - media: " + mean_walkingUp_y);
%         disp("WalkingUp Z - media: " + mean_walkingUp_z);

%         std_walkingUp_x = std(steps_x_wu);
%         std_walkingUp_y = std(steps_y_wu);
%         std_walkingUp_z = std(steps_z_wu);
%         disp("WalkingUp X - desvio padrao: " + std_walkingUp_x);
%         disp("WalkingUp Y - desvio padrao: " + std_walkingUp_y);
%         disp("WalkingUp Z - desvio padrao: " + std_walkingUp_z);

        %walking down

        mean_walkingDown_x = mean(steps_x_wd);
        mean_walkingDown_y = mean(steps_y_wd);
        mean_walkingDown_z = mean(steps_z_wd);
%         disp("WalkingDown X - media: " + mean_walkingDown_x);
%         disp("WalkingDown Y - media: " + mean_walkingDown_y);
%         disp("WalkingDown Z - media: " + mean_walkingDown_z);

%         std_walkingDown_x = std(steps_x_wd);
%         std_walkingDown_y = std(steps_y_wd);
%         std_walkingDown_z = std(steps_z_wd);
%         disp("WalkingDown X - desvio padrao: " + std_walkingDown_x);
%         disp("WalkingDown Y - desvio padrao: " + std_walkingDown_y);
%         disp("WalkingDown Z - desvio padrao: " + std_walkingDown_z);
        
        avg_steps_x_w = [avg_steps_x_w, mean_walking_x];
        avg_steps_x_wu = [avg_steps_x_wu, mean_walkingUp_x];
        avg_steps_x_wd = [avg_steps_x_wd, mean_walkingDown_x];
        avg_steps_y_w = [avg_steps_y_w, mean_walking_y];
        avg_steps_y_wu = [avg_steps_y_wu, mean_walkingUp_y];
        avg_steps_y_wd = [avg_steps_y_wd, mean_walkingDown_y];
        avg_steps_z_w = [avg_steps_z_w, mean_walking_z];
        avg_steps_z_wu = [avg_steps_z_wu, mean_walkingUp_z];
        avg_steps_z_wd = [avg_steps_z_wd, mean_walkingDown_z];

    end

    final_mean_w_x = mean(avg_steps_x_w);
    final_std_w_x = std(avg_steps_x_w);
    final_mean_w_y = mean(avg_steps_y_w);
    final_std_w_y = std(avg_steps_y_w);
    final_mean_w_z = mean(avg_steps_z_w);
    final_std_w_z = std(avg_steps_z_w);
    
    disp("Walking X - media: " + final_mean_w_x);
    disp("Walking Y - media: " + final_mean_w_y);
    disp("Walking Z - media: " + final_mean_w_z);
    disp("Walking X - desvio padrao: " + final_std_w_x);
    disp("Walking Y - desvio padrao: " + final_std_w_y);
    disp("Walking Z - desvio padrao: " + final_std_w_z);
    
    final_mean_wu_x = mean(avg_steps_x_wu);
    final_std_wu_x = std(avg_steps_x_wu);
    final_mean_wu_y = mean(avg_steps_y_wu);
    final_std_wu_y = std(avg_steps_y_wu);
    final_mean_wu_z = mean(avg_steps_z_wu);
    final_std_wu_z = std(avg_steps_z_wu);
    
    disp("WalkingUp X - media: " + final_mean_wu_x);
    disp("WalkingUp Y - media: " + final_mean_wu_y);
    disp("WalkingUp Z - media: " + final_mean_wu_z);
    disp("WalkingUp X - desvio padrao: " + final_std_wu_x);
    disp("WalkingUp Y - desvio padrao: " + final_std_wu_y);
    disp("WalkingUp Z - desvio padrao: " + final_std_wu_z);
    
    final_mean_wd_x = mean(avg_steps_x_wd);
    final_std_wd_x = std(avg_steps_x_wd);
    final_mean_wd_y = mean(avg_steps_y_wd);
    final_std_wd_y = std(avg_steps_y_wd);
    final_mean_wd_z = mean(avg_steps_z_wd);
    final_std_wd_z = std(avg_steps_z_wd);
       
    disp("WalkingDown X - media: " + final_mean_wd_x);
    disp("WalkingDown Y - media: " + final_mean_wd_y);
    disp("WalkingDown Z - media: " + final_mean_wd_z);
    disp("WalkingDown X - desvio padrao: " + final_std_wd_x);
    disp("WalkingDown Y - desvio padrao: " + final_std_wd_y);
    disp("WalkingDown Z - desvio padrao: " + final_std_wd_z);
    
    
end