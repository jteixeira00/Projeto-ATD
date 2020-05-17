function [aac_x_mod, aac_y_mod, aac_z_mod] = dynamicActivitiesDFT(data)
    x_component = data(:, 1);
    y_component = data(:, 2);
    z_component = data(:, 3);
    
    hammingWindow = hamming(length(x_component));
    
    aac_x_mod = abs(fftshift(fft(detrend(x_component(:,:))))).*hammingWindow;
    aac_y_mod = abs(fftshift(fft(detrend(y_component(:,:))))).*hammingWindow;
    aac_z_mod = abs(fftshift(fft(detrend(z_component(:,:))))).*hammingWindow;