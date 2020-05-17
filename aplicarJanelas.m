function [] = aplicarJanelas(dataLabels, signal_x, signal_y, signal_z)
    
    activity_names = ["Walking", "Walking Up", "Walking Down", "Siting", "Standing", "Laying", "Stand to sit", "Sit to stand","Sit to lie","Lie to sit", "Stand to lie", "Lie to stand"];
    
    fs = 50;        %frequencia de amostragem
    Ts = 1/fs;      %periodo de amostragem
      

    counters = zeros(1,12);     %para verificar se uma atividade já foi analisada

    for i=1:length(dataLabels)
        
        start = dataLabels(i,4);
        finish = dataLabels(i,5);
        window = start : finish;
        activityID = dataLabels(i,3);
        activity_name = activity_names(activityID);
        windowSize = finish - start + 1;
        
        if(counters(activityID) == 1)
            %ja analisamos a atividade, portanto ignoramos
            continue
        end
        
        atividade_x = signal_x(start : finish);
        
        
        % HAmming
        %JANELA DESLIZANTE
        
        Tframe = 2;                 % largura da janela de análise em s
        Toverlap = 1;               % sobreposiçao das janelas em s
        Nframe = round(Tframe*fs);              % número de amostras na janela
        Noverlap = round(Toverlap*fs);          % número de amostras sobrepostas na janela

        h = hamming(Nframe); % janela de hamming

        if mod(Nframe, 2)==0
            f_frame = -fs/2:fs/Nframe:fs/2-fs/Nframe;
        else 
            f_frame = -fs/2+fs/(2*Nframe):fs/Nframe:...
                fs/2-fs/(2*Nframe);
        end

        frequencias = [];
        magnitudes = [];

        for ii = 1:Nframe-Noverlap:N-Nframe
            % aplicar a janela ao sinal do tempo
            x_frame = atividade_x(ii:ii+Nframe-1).*h;

            % obter a magnitude da fft do sinal
            m_X_frame = abs(fftshift(fft(x_frame)));

            % obter o máximo da magnitude do sinal
            m_X_frame_max = max(m_X_frame);

            % encontrar os índices do máximo da magnitude do sinal
            ind = find(abs(m_X_frame-m_X_frame_max)<0.001);

            % encontrar as frequências correspondentes ao máximo de magnitude
            freq_relev = [freq_relev, f_frame(ind(2))];


            % calcular o vetor de tempo correspondente a cada janela, que aqui
            % corresponde ao valor do vetor de tempos, t, em cada janela
            t_frame = t(ii:ii+Nframe-1);
            tframes = [tframes, t_frame(round(Nframe/2)+1)];
        end
        
        
        
        
        
        figure("Name", activity_name + " - Janelas",'NumberTitle','off');
        
        subplot(3,3, 1);
        plot(f, magnitudes_x);
        title("Hamming" + ' X ')
        subplot(3,3, 2);
        plot(f, magnitudes_y);
        title("Hamming" + ' Y ')
        subplot(3,3, 3);
        plot(f_frame, magnitudes_z);
        title("Hamming" + ' Z ');


%         %hann  
%         hannWindow = hann(windowSize);
%         
%         dft_x = abs(fftshift(fft(signal_x(window(1):window(end),:))));
%         dft_y = abs(fftshift(fft(signal_y(window(1):window(end),:))));
%         dft_z = abs(fftshift(fft(signal_z(window(1):window(end),:))));
%         
%         aac_x_mod = dft_x.*hannWindow;
%         aac_y_mod = dft_y.*hannWindow;
%         aac_z_mod = dft_z.*hannWindow;
%         
%         subplot(3,3, 4);
%         plot(t1, aac_x_mod);
%         title("Hann" + ' X ')
%         subplot(3,3, 5);
%         plot(t1, aac_y_mod);
%         title("Hann" + ' Y ')
%         subplot(3,3, 6);
%         plot(t1, aac_z_mod);
%         title("Hann" + ' Z ');
% 
%         %hann  
%         blackmanWindow = blackman(windowSize);
%         
%         dft_x = abs(fftshift(fft(signal_x(window(1):window(end),:))));
%         dft_y = abs(fftshift(fft(signal_y(window(1):window(end),:))));
%         dft_z = abs(fftshift(fft(signal_z(window(1):window(end),:))));
%         
%         aac_x_mod = dft_x.*blackmanWindow;
%         aac_y_mod = dft_y.*blackmanWindow;
%         aac_z_mod = dft_z.*blackmanWindow;
% 
%         subplot(3,3, 7);
%         plot(t1, aac_x_mod);
%         title("Blackman" + ' X ')
%         subplot(3,3, 8);
%         plot(t1, aac_y_mod);
%         title("Blackman" + ' Y ')
%         subplot(3,3, 9);
%         plot(t1, aac_z_mod);
%         title("Blackman" + ' Z ');   
        
        counters(activityID) = 1;
    end
end