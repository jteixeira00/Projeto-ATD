function [] = aplicarJanelas(dataLabels, signal_x, signal_y, signal_z)
    
    fs = 50;
    Ts = 1/fs;      %periodo de amostragem
    activity_names = ["Walking", "Walking Up", "Walking Down", "Siting", "Standing", "Laying", "Stand to sit", "Sit to stand","Sit to lie","Lie to sit", "Stand to lie", "Lie to stand"];
      
    counters = zeros(1,12);     %para verificar se uma atividade j� foi analisada

    for i=1:length(dataLabels)
        
        start = dataLabels(i,4);
        finish = dataLabels(i,5);
        window = start : finish;
        activityID = dataLabels(i,3);
        activity_name = activity_names(activityID);
        windowSize = finish - start + 1;
        N = windowSize;
    
        if(counters(activityID) == 1)
            %ja analisamos a atividade, portanto ignoramos
            continue
        end
        
        atividade_x = signal_x(start : finish);
        atividade_y = signal_y(start : finish);
        atividade_z = signal_z(start : finish);
        
        figure("Name", activity_name + " - Janelas",'NumberTitle','off');
        
        
        %DFT normal
        
        %vetor de frequencias
        if(mod(N,2)==0)
            f = -fs/2 : fs/N : fs/2-fs/N;
        else
            f = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
        end

        dft_sem_tendX = abs(fftshift(fft(detrend(atividade_x)))); %detrend = tirar tendencia

        dft_sem_tendY = abs(fftshift(fft(detrend(atividade_y)))); %detrend = tirar tendencia

        dft_sem_tendZ = abs(fftshift(fft(detrend(atividade_z)))); %detrend = tirar tendencia

    
        subplot(3,4, 1);
        plot(f, dft_sem_tendX, 'o');
        title("DTF" + ' X ')
        subplot(3,4, 5);
        plot(f, dft_sem_tendY, 'o');
        title("DTF" + ' Y ')
        subplot(3,4, 9);
        plot(f, dft_sem_tendZ, 'o');
        title("DFT" + ' Z ');
        
        
        % HAmming
        %JANELA DESLIZANTE
        
        Tframe = 4;                 % largura da janela de an�lise em s
        Toverlap = 1;               % sobreposi�ao das janelas em s
        Nframe = round(Tframe*fs);              % n�mero de amostras na janela
        Noverlap = round(Toverlap*fs);          % n�mero de amostras sobrepostas na janela


        if mod(Nframe, 2)==0
            f_frame = -fs/2:fs/Nframe:fs/2-fs/Nframe;
        else 
            f_frame = -fs/2+fs/(2*Nframe):fs/Nframe:...
                fs/2-fs/(2*Nframe);
        end

        
        frequencias_x = [];
        magnitudes_x = [];
        frequencias_y = [];
        magnitudes_y = [];
        frequencias_z = [];
        magnitudes_z = [];
        
        if(Nframe >= windowSize)
            h = hamming(windowSize); % janela de hamming
            x_frame = atividade_x.*h;
            y_frame = atividade_y.*h;
            z_frame = atividade_z.*h;

            % obter a magnitude da fft do sinal
            m_X_frame = abs(fftshift(fft(detrend(x_frame))));
            m_Y_frame = abs(fftshift(fft(detrend(y_frame))));
            m_Z_frame = abs(fftshift(fft(detrend(z_frame))));

%             m_X_frame = m_X_frame/Nframe*2;
%             m_Y_frame = m_Y_frame/Nframe*2;
%             m_Z_frame = m_Z_frame/Nframe*2;
            
            % obter o m�ximo da magnitude do sinal
            m_X_frame_max = max(m_X_frame);
            m_Y_frame_max = max(m_Y_frame);
            m_Z_frame_max = max(m_Z_frame);
% 
%             % encontrar os �ndices do m�ximo da magnitude do sinal
            freqs_relevantes_x = f_frame(m_X_frame == m_X_frame_max);
            freqs_relevantes_y = f_frame(m_Y_frame == m_Y_frame_max);
            freqs_relevantes_z = f_frame(m_Z_frame == m_Z_frame_max);

            frequencias_x = [frequencias_x, abs(freqs_relevantes_x(1))];
            frequencias_y = [frequencias_y, abs(freqs_relevantes_y(1))];
            frequencias_z = [frequencias_z, abs(freqs_relevantes_z(1))];

            magnitudes_x = [magnitudes_x, m_X_frame_max];
            magnitudes_y = [magnitudes_y, m_Y_frame_max];
            magnitudes_z = [magnitudes_z, m_Z_frame_max];
            
        else
            
            h = hamming(Nframe); % janela de hamming
            for ii = 1:Nframe-Noverlap:N-Nframe
                % aplicar a janela ao sinal do tempo
                x_frame = atividade_x(ii:ii+Nframe-1).*h;
                y_frame = atividade_y(ii:ii+Nframe-1).*h;
                z_frame = atividade_z(ii:ii+Nframe-1).*h;

                % obter a magnitude da fft do sinal
                m_X_frame = abs(fftshift(fft(detrend(x_frame))));
                m_Y_frame = abs(fftshift(fft(detrend(y_frame))));
                m_Z_frame = abs(fftshift(fft(detrend(z_frame))));
% 
%                 m_X_frame = m_X_frame/Nframe*2;
%                 m_Y_frame = m_Y_frame/Nframe*2;
%                 m_Z_frame = m_Z_frame/Nframe*2;

                % obter o m�ximo da magnitude do sinal
                m_X_frame_max = max(m_X_frame);
                m_Y_frame_max = max(m_Y_frame);
                m_Z_frame_max = max(m_Z_frame);
                
                % encontrar os �ndices do m�ximo da magnitude do sinal
                freqs_relevantes_x = f_frame(m_X_frame == m_X_frame_max);
                freqs_relevantes_y = f_frame(m_Y_frame == m_Y_frame_max);
                freqs_relevantes_z = f_frame(m_Z_frame == m_Z_frame_max);

                frequencias_x = [frequencias_x, abs(freqs_relevantes_x(1))];
                frequencias_y = [frequencias_y, abs(freqs_relevantes_y(1))];
                frequencias_z = [frequencias_z, abs(freqs_relevantes_z(1))];
                
                magnitudes_x = [magnitudes_x, m_X_frame_max];
                magnitudes_y = [magnitudes_y, m_Y_frame_max];
                magnitudes_z = [magnitudes_z, m_Z_frame_max];

            end
        end
        
        
        subplot(3,4, 2);
        plot(frequencias_x, magnitudes_x, 'o');
        title("Hamming" + ' X ')
        subplot(3,4, 3);
        plot(frequencias_y, magnitudes_y, 'o');
        title("Hamming" + ' Y ')
        subplot(3,4, 4);
        plot(frequencias_z, magnitudes_z, 'o');
        title("Hamming" + ' Z ');


%         %hann  
        frequencias_x = [];
        magnitudes_x = [];
        frequencias_y = [];
        magnitudes_y = [];
        frequencias_z = [];
        magnitudes_z = [];
        
        if(Nframe >= windowSize)
            h = hann(windowSize); % janela de hamming
            x_frame = atividade_x.*h;
            y_frame = atividade_y.*h;
            z_frame = atividade_z.*h;

            % obter a magnitude da fft do sinal
            m_X_frame = abs(fftshift(fft(detrend(x_frame))));
            m_Y_frame = abs(fftshift(fft(detrend(y_frame))));
            m_Z_frame = abs(fftshift(fft(detrend(z_frame))));

%             m_X_frame = m_X_frame/Nframe*2;
%             m_Y_frame = m_Y_frame/Nframe*2;
%             m_Z_frame = m_Z_frame/Nframe*2;
            
            % obter o m�ximo da magnitude do sinal
            m_X_frame_max = max(m_X_frame);
            m_Y_frame_max = max(m_Y_frame);
            m_Z_frame_max = max(m_Z_frame);
% 
%             % encontrar os �ndices do m�ximo da magnitude do sinal
            freqs_relevantes_x = f_frame(m_X_frame == m_X_frame_max);
            freqs_relevantes_y = f_frame(m_Y_frame == m_Y_frame_max);
            freqs_relevantes_z = f_frame(m_Z_frame == m_Z_frame_max);

            frequencias_x = [frequencias_x, abs(freqs_relevantes_x(1))];
            frequencias_y = [frequencias_y, abs(freqs_relevantes_y(1))];
            frequencias_z = [frequencias_z, abs(freqs_relevantes_z(1))];

            magnitudes_x = [magnitudes_x, m_X_frame_max];
            magnitudes_y = [magnitudes_y, m_Y_frame_max];
            magnitudes_z = [magnitudes_z, m_Z_frame_max];
            
        else
            
            h = hann(Nframe); % janela de hamming
            for ii = 1:Nframe-Noverlap:N-Nframe
                % aplicar a janela ao sinal do tempo
                x_frame = atividade_x(ii:ii+Nframe-1).*h;
                y_frame = atividade_y(ii:ii+Nframe-1).*h;
                z_frame = atividade_z(ii:ii+Nframe-1).*h;

                % obter a magnitude da fft do sinal
                m_X_frame = abs(fftshift(fft(detrend(x_frame))));
                m_Y_frame = abs(fftshift(fft(detrend(y_frame))));
                m_Z_frame = abs(fftshift(fft(detrend(z_frame))));

%                 m_X_frame = m_X_frame/Nframe*2;
%                 m_Y_frame = m_Y_frame/Nframe*2;
%                 m_Z_frame = m_Z_frame/Nframe*2;

                % obter o m�ximo da magnitude do sinal
                m_X_frame_max = max(m_X_frame);
                m_Y_frame_max = max(m_Y_frame);
                m_Z_frame_max = max(m_Z_frame);
                
                % encontrar os �ndices do m�ximo da magnitude do sinal
                freqs_relevantes_x = f_frame(m_X_frame == m_X_frame_max);
                freqs_relevantes_y = f_frame(m_Y_frame == m_Y_frame_max);
                freqs_relevantes_z = f_frame(m_Z_frame == m_Z_frame_max);

                frequencias_x = [frequencias_x, abs(freqs_relevantes_x(1))];
                frequencias_y = [frequencias_y, abs(freqs_relevantes_y(1))];
                frequencias_z = [frequencias_z, abs(freqs_relevantes_z(1))];
                
                magnitudes_x = [magnitudes_x, m_X_frame_max];
                magnitudes_y = [magnitudes_y, m_Y_frame_max];
                magnitudes_z = [magnitudes_z, m_Z_frame_max];

            end
        end
        
        subplot(3,4, 6);
        plot(frequencias_x, magnitudes_x, 'o');
        title("Hann" + ' X ')
        subplot(3,4, 7);
        plot(frequencias_y, magnitudes_y, 'o');
        title("Hann" + ' Y ')
        subplot(3,4, 8);
        plot(frequencias_z, magnitudes_z, 'o');
        title("Hann" + ' Z ');
% 
%         %blackman  
        frequencias_x = [];
        magnitudes_x = [];
        frequencias_y = [];
        magnitudes_y = [];
        frequencias_z = [];
        magnitudes_z = [];
        
        if(Nframe >= windowSize)
            h = blackman(windowSize); % janela de hamming
            x_frame = atividade_x.*h;
            y_frame = atividade_y.*h;
            z_frame = atividade_z.*h;

            % obter a magnitude da fft do sinal
            m_X_frame = abs(fftshift(fft(detrend(x_frame))));
            m_Y_frame = abs(fftshift(fft(detrend(y_frame))));
            m_Z_frame = abs(fftshift(fft(detrend(z_frame))));
% 
%             m_X_frame = m_X_frame/Nframe*2;
%             m_Y_frame = m_Y_frame/Nframe*2;
%             m_Z_frame = m_Z_frame/Nframe*2;
            
            % obter o m�ximo da magnitude do sinal
            m_X_frame_max = max(m_X_frame);
            m_Y_frame_max = max(m_Y_frame);
            m_Z_frame_max = max(m_Z_frame);
% 
%             % encontrar os �ndices do m�ximo da magnitude do sinal
            freqs_relevantes_x = f_frame(m_X_frame == m_X_frame_max);
            freqs_relevantes_y = f_frame(m_Y_frame == m_Y_frame_max);
            freqs_relevantes_z = f_frame(m_Z_frame == m_Z_frame_max);

            frequencias_x = [frequencias_x, abs(freqs_relevantes_x(1))];
            frequencias_y = [frequencias_y, abs(freqs_relevantes_y(1))];
            frequencias_z = [frequencias_z, abs(freqs_relevantes_z(1))];

            magnitudes_x = [magnitudes_x, m_X_frame_max];
            magnitudes_y = [magnitudes_y, m_Y_frame_max];
            magnitudes_z = [magnitudes_z, m_Z_frame_max];
            
        else
            
            h = blackman(Nframe); % janela de hamming
            for ii = 1:Nframe-Noverlap:N-Nframe
                % aplicar a janela ao sinal do tempo
                x_frame = atividade_x(ii:ii+Nframe-1).*h;
                y_frame = atividade_y(ii:ii+Nframe-1).*h;
                z_frame = atividade_z(ii:ii+Nframe-1).*h;

                % obter a magnitude da fft do sinal
                m_X_frame = abs(fftshift(fft(detrend(x_frame))));
                m_Y_frame = abs(fftshift(fft(detrend(y_frame))));
                m_Z_frame = abs(fftshift(fft(detrend(z_frame))));

%                 m_X_frame = m_X_frame/Nframe*2;
%                 m_Y_frame = m_Y_frame/Nframe*2;
%                 m_Z_frame = m_Z_frame/Nframe*2;

                % obter o m�ximo da magnitude do sinal
                m_X_frame_max = max(m_X_frame);
                m_Y_frame_max = max(m_Y_frame);
                m_Z_frame_max = max(m_Z_frame);
                
                % encontrar os �ndices do m�ximo da magnitude do sinal
                freqs_relevantes_x = f_frame(m_X_frame == m_X_frame_max);
                freqs_relevantes_y = f_frame(m_Y_frame == m_Y_frame_max);
                freqs_relevantes_z = f_frame(m_Z_frame == m_Z_frame_max);

                frequencias_x = [frequencias_x, abs(freqs_relevantes_x(1))];
                frequencias_y = [frequencias_y, abs(freqs_relevantes_y(1))];
                frequencias_z = [frequencias_z, abs(freqs_relevantes_z(1))];
                
                magnitudes_x = [magnitudes_x, m_X_frame_max];
                magnitudes_y = [magnitudes_y, m_Y_frame_max];
                magnitudes_z = [magnitudes_z, m_Z_frame_max];

            end
        end
        
        subplot(3,4, 10);
        plot(frequencias_x, magnitudes_x, 'o');
        title("Blackman" + ' X ')
        subplot(3,4, 11);
        plot(frequencias_y, magnitudes_y, 'o');
        title("Blackman" + ' Y ')
        subplot(3,4, 12);
        plot(frequencias_z, magnitudes_z, 'o');
        title("Blackman" + ' Z ');
        
        counters(activityID) = 1;
    end
end