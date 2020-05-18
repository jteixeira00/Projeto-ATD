function [] = aplicarJanelas(dataLabels, signal_x, signal_y, signal_z)
    fs = 50;        %Hz
    activity_names = ["Walking", "Walking Up", "Walking Down", "Siting", "Standing", "Laying", "Stand to sit", "Sit to stand","Sit to lie","Lie to sit", "Stand to lie", "Lie to stand"];
    counters = zeros(1,12);     %para verificar se uma atividade já foi apresentada no grafico

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
            
        if(mod(windowSize,2)==0)
            f = -fs/2 : fs/windowSize : fs/2-fs/windowSize;
        else
            f = -fs/2+fs/(2*windowSize):fs/windowSize:fs/2-fs/(2*windowSize);
        end
        
        figure("Name", activity + " - Janelas",'NumberTitle','off');
        
        %dft normal

        janelada_x = signal_x(window(1):window(end),:);
        janelada_y = signal_y(window(1):window(end),:);
        janelada_z = signal_z(window(1):window(end),:);
        
        dft_x = abs(fftshift(fft(janelada_x)));
        dft_y = abs(fftshift(fft(janelada_y)));
        dft_z = abs(fftshift(fft(janelada_z)));

        subplot(3,4, 1);
        plot(f, dft_x, 'o');
        title("DFT" + ' X ')
        subplot(3,4, 5);
        plot(f, dft_y, 'o');
        title("DFT" + ' Y ')
        subplot(3,4, 9);
        plot(f, dft_z, 'o');
        title("DFT" + ' Z ');

        %hamming
        hammingWindow = hamming(windowSize);

        janelada_x = signal_x(window(1):window(end),:).*hammingWindow;
        janelada_y = signal_y(window(1):window(end),:).*hammingWindow;
        janelada_z = signal_z(window(1):window(end),:).*hammingWindow;
        
        dft_x = abs(fftshift(fft(janelada_x)));
        dft_y = abs(fftshift(fft(janelada_y)));
        dft_z = abs(fftshift(fft(janelada_z)));

        subplot(3,4, 2);
        plot(f, dft_x, 'o');
        title("Hamming" + ' X ')
        subplot(3,4, 6, 'o');
        plot(f, dft_y, 'o');
        title("Hamming" + ' Y ')
        subplot(3,4, 10);
        plot(f, dft_z, 'o');
        title("Hamming" + ' Z ');


        %hann  
        hannWindow = hann(windowSize);

        janelada_x = signal_x(window(1):window(end),:).*hannWindow;
        janelada_y = signal_y(window(1):window(end),:).*hannWindow;
        janelada_z = signal_z(window(1):window(end),:).*hannWindow;
        
        dft_x = abs(fftshift(fft(janelada_x)));
        dft_y = abs(fftshift(fft(janelada_y)));
        dft_z = abs(fftshift(fft(janelada_z)));

        subplot(3,4, 3);
        plot(f, dft_x, 'o');
        title("Hann" + ' X ')
        subplot(3,4, 7, 'o');
        plot(f, dft_y, 'o');
        title("Hann" + ' Y ')
        subplot(3,4, 11);
        plot(f, dft_z, 'o');
        title("Hann" + ' Z ');

        %hann  
        blackmanWindow = blackman(windowSize);

        janelada_x = signal_x(window(1):window(end),:).*blackmanWindow;
        janelada_y = signal_y(window(1):window(end),:).*blackmanWindow;
        janelada_z = signal_z(window(1):window(end),:).*blackmanWindow;
        
        dft_x = abs(fftshift(fft(janelada_x)));
        dft_y = abs(fftshift(fft(janelada_y)));
        dft_z = abs(fftshift(fft(janelada_z)));
        
        subplot(3,4, 4);
        plot(f, dft_x, 'o');
        title("Blackman" + ' X ')
        subplot(3,4, 8);
        plot(f, dft_y, 'o');
        title("Blackman" + ' Y ')
        subplot(3,4, 12);
        plot(f, dft_z, 'o');
        title("Blackman" + ' Z ');   

        counters(activityID) = 1;
    end
    
    wvtool(hamming(windowSize),hann(windowSize),blackman(windowSize));
end 