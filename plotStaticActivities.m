function [aac_x_mod, aac_y_mod, aac_z_mod] = plotStaticActivities(data, start, finish, activityID, figureID)
    %periodo de amostragem, tendo em conta que a frequencia de amostragem é
    %50 Hz
    Ts = 1/50 ;  
    x_component = data(:, 1);
    y_component = data(:, 2);
    z_component = data(:, 3);
    
    window = start:finish;    %window slice that contains activity
    
    if(activityID == 4) 
        activity = "Sitting";
    elseif(activityID == 5)
        activity = "Standing";
    elseif(activityID == 6)   
        activity = "Laying";     
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
    % 3*(activityID-4) dá nos a linha certa consoante a atividade
    subplot(3,3, 1 + 3*(activityID-4));
    plot(t, aac_x_mod);
    title(activity + ' X ')
    subplot(3,3, 2 + 3*(activityID-4));
    plot(t, aac_y_mod);
    title(activity + ' Y ')
    subplot(3,3, 3 + 3*(activityID-4));
    plot(t, aac_z_mod);
    title(activity + ' Z ');
    hold on;
end