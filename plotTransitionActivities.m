function [aac_x_mod, aac_y_mod, aac_z_mod] = plotTransitionActivities(data, start, finish, activityID, figureID)
    %periodo de amostragem, tendo em conta que a frequencia de amostragem é
    %50 Hz
    Ts = 1/50 ;  
    x_component = data(:, 1);
    y_component = data(:, 2);
    z_component = data(:, 3);
    
    window = start:finish;    %window slice that contains activity
    
    if(activityID == 7) 
        activity = "Stand to sit";
    elseif(activityID == 8)
        activity = "Sit to stan";
    elseif(activityID == 9)   
        activity = "Sit to lie";
    elseif(activityID == 10)
        activity = "Lie to sit";
    elseif(activityID == 11)   
        activity = "Stand to lie";
    elseif(activityID == 12)
        activity = "Lie to stand";
    else
        disp("Invalid activity ID");
    end
    
    windowSize=finish-start+1;
    hammingWindow = hamming(windowSize);
    aac_x_mod = abs(fftshift(fft(detrend(x_component(window(1):window(end),:))))).*hammingWindow;
    aac_y_mod = abs(fftshift(fft(detrend(y_component(window(1):window(end),:))))).*hammingWindow;
    aac_z_mod = abs(fftshift(fft(detrend(z_component(window(1):window(end),:))))).*hammingWindow;
    
    t = linspace(0,Ts*(windowSize-1)/60,windowSize)';  %array of times for the plot
    
    figure(figureID);
    % 3*(activityID-7) dá nos a linha certa consoante a atividade
    subplot(3,6, 1 + 3*(activityID-7));
    plot(t, aac_x_mod);
    title(activity + ' X ')
    subplot(3,6, 2 + 3*(activityID-7));
    plot(t, aac_y_mod);
    title(activity + ' Y ')
    subplot(3,6, 3 + 3*(activityID-7));
    plot(t, aac_z_mod);
    title(activity + ' Z ');
    hold on;
end