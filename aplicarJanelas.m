function [] = aplicarJanelas(dataLabels, signal_x, signal_y, signal_z)
    
    Ts = 1/50;      %periodo de amostragem
    activity_names = ["Walking", "Walking Up", "Walking Down", "Siting", "Standing", "Laying", "Stand to sit", "Sit to stand","Sit to lie","Lie to sit", "Stand to lie", "Lie to stand"];
    counters = zeros(1,12);     %para verificar se uma atividade j� foi apresentada no grafico
    
    for i=1:length(dataLabels)
        start = dataLabels(i,4);
        finish = dataLabels(i,5);
        window = start : finish;
        activityID = dataLabels(i,3);
        activity = activity_names(activityID);
        windowSize = finish - start + 1;
        
        if(counters(activityID) == 1)
            %ja analisamos a atividade, portanto ignoramos
            continue
        end
        
        %hamming
        hammingWindow = hamming(windowSize);

        dft_x = abs(fftshift(fft(signal_x(window(1):window(end),:))));
        dft_y = abs(fftshift(fft(signal_y(window(1):window(end),:))));
        dft_z = abs(fftshift(fft(signal_z(window(1):window(end),:))));
        
        aac_x_mod = dft_x.*hammingWindow;
        aac_y_mod = dft_y.*hammingWindow;
        aac_z_mod = dft_z.*hammingWindow;
        
        t1 = linspace(0,Ts*(windowSize-1)/60,windowSize)';
        figure("Name", activity + " - Janelas",'NumberTitle','off');
        
        subplot(3,3, 1);
        plot(t1, aac_x_mod);
        title("Hamming" + ' X ')
        subplot(3,3, 2);
        plot(t1, aac_y_mod);
        title("Hamming" + ' Y ')
        subplot(3,3, 3);
        plot(t1, aac_z_mod);
        title("Hamming" + ' Z ');


        %hann  
        hannWindow = hann(windowSize);
        
        dft_x = abs(fftshift(fft(signal_x(window(1):window(end),:))));
        dft_y = abs(fftshift(fft(signal_y(window(1):window(end),:))));
        dft_z = abs(fftshift(fft(signal_z(window(1):window(end),:))));
        
        aac_x_mod = dft_x.*hannWindow;
        aac_y_mod = dft_y.*hannWindow;
        aac_z_mod = dft_z.*hannWindow;
        
        subplot(3,3, 4);
        plot(t1, aac_x_mod);
        title("Hann" + ' X ')
        subplot(3,3, 5);
        plot(t1, aac_y_mod);
        title("Hann" + ' Y ')
        subplot(3,3, 6);
        plot(t1, aac_z_mod);
        title("Hann" + ' Z ');

        %hann  
        blackmanWindow = blackman(windowSize);
        
        dft_x = abs(fftshift(fft(signal_x(window(1):window(end),:))));
        dft_y = abs(fftshift(fft(signal_y(window(1):window(end),:))));
        dft_z = abs(fftshift(fft(signal_z(window(1):window(end),:))));
        
        aac_x_mod = dft_x.*blackmanWindow;
        aac_y_mod = dft_y.*blackmanWindow;
        aac_z_mod = dft_z.*blackmanWindow;

        subplot(3,3, 7);
        plot(t1, aac_x_mod);
        title("Blackman" + ' X ')
        subplot(3,3, 8);
        plot(t1, aac_y_mod);
        title("Blackman" + ' Y ')
        subplot(3,3, 9);
        plot(t1, aac_z_mod);
        title("Blackman" + ' Z ');   
        
        counters(activityID) = 1;
    end
end