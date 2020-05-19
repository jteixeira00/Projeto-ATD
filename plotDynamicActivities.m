function [max_dft_x, max_dft_y, max_dft_z] = plotDynamicActivities(data, start, finish, activityID, figureID, showPlot)
    %periodo de amostragem, tendo em conta que a frequencia de amostragem é
    %50 Hz
    fs = 50;
    Ts = 1/fs ;
    windowSize=finish-start+1;
    x_component = data(:, 1);
    y_component = data(:, 2);
    z_component = data(:, 3);
    N = windowSize;
    
    if(mod(N,2)==0)
        f = -fs/2 : fs/N : fs/2-fs/N;
    else
        f = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
    end
    
    window = start:finish;    %window slice that contains activity
    
    if(activityID == 1) 
        activity = "Walking";
    elseif(activityID == 2)
        activity = "Walking Up";
    elseif(activityID == 3)   
        activity = "Walking Down";     
    else
        disp("Invalid activity ID");
    end
    
    hammingWindow = hamming(windowSize);
    
    %{
    %aplicar primeiro a hamming window ao sinal
    aac_x_ham = x_component(window(), :).*hammingWindow;
    aac_y_ham = y_component(window(), :).*hammingWindow;
    aac_z_ham = z_component(window(), :).*hammingWindow;
    
    
    %aplicar dft a hamming window
    aac_x_mod = abs(fftshift(fft(detrend(aac_x_ham))));
    aac_y_mod = abs(fftshift(fft(detrend(aac_y_ham))));
    aac_z_mod = abs(fftshift(fft(detrend(aac_z_ham))));
    %}
    
    aac_x_mod = abs(fftshift(fft(detrend(x_component(window(1):window(end),:))))).*hammingWindow;
    aac_y_mod = abs(fftshift(fft(detrend(y_component(window(1):window(end),:))))).*hammingWindow;
    aac_z_mod = abs(fftshift(fft(detrend(z_component(window(1):window(end),:))))).*hammingWindow;
    
    %t = linspace(0,Ts*(windowSize-1)/60,windowSize)';  %array of times for the plot
    
    if(showPlot == true)
        
        figure(figureID);
        % 3*(activityID-1) dá nos a linha certa consoante a atividade
        subplot(3,3, 1 + 3*(activityID-1));
        plot(f, aac_x_mod);
        hold on
        title(activity + ' X ');
        subplot(3,3, 2 + 3*(activityID-1));
        plot(f, aac_y_mod);
        hold on
        title(activity + ' Y ');
        subplot(3,3, 3 + 3*(activityID-1));
        plot(f, aac_z_mod);
        hold on
        title(activity + ' Z ');
    end
    
    max_dft_x = max(aac_x_mod);
    max_dft_y = max(aac_y_mod);
    max_dft_z = max(aac_z_mod);
end