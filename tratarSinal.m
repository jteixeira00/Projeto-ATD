function [dft_sem_tendX, dft_sem_tendY, dft_sem_tendZ] = tratarSinal(sinalX, sinalY, sinalZ, showPlot)
    N = length(sinalX);         %tamanho do sinal
    fs = 50;                    %frequencia de amostragem, 50 Hz
    Ts = 1 /fs;                 %periodo de amostragem, inverso da frequencia
    
    %vetor de frequencias
    if(mod(N,2)==0)
        f = -fs/2 : fs/N : fs/2-fs/N;
    else
        f = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
    end
    
    t1 = linspace(0,Ts*(N-1)/60,N);
    dft_com_tendX = abs(fftshift(fft(sinalX)));
    dft_sem_tendX = abs(fftshift(fft(detrend(sinalX)))); %detrend = tirar tendencia
    
    dft_com_tendY = abs(fftshift(fft(sinalY)));
    dft_sem_tendY = abs(fftshift(fft(detrend(sinalY)))); %detrend = tirar tendencia
    
    dft_com_tendZ = abs(fftshift(fft(sinalZ)));
    dft_sem_tendZ = abs(fftshift(fft(detrend(sinalZ)))); %detrend = tirar tendencia
    
    if(showPlot == true)
        figure("Name", "Tratar sinal")
        %X
        subplot(3,3,1);
        plot(t1, sinalX);
        xlabel('t[s]')
        ylabel('Amplitude')
        title("Sinal original - X");
        hold on

        subplot(3,3,4);
        plot(f, dft_com_tendX(:));
        xlabel('f[Hz]')
        ylabel('Magnitude |X|')
        title("DFT do sinal - X");
        hold on

        subplot(3,3,7);
        plot(f, dft_sem_tendX(:));
        xlabel('f[Hz]')
        ylabel('Magnitude |X|')
        title("DFT do sinal sem tendencia - X");
        hold on

        %Y
        subplot(3,3,2);
        plot(t1, sinalY);
        xlabel('t[s]')
        ylabel('Amplitude')
        title("Sinal original - Y");
        hold on

        subplot(3,3,5);
        plot(f, dft_com_tendY(:));
        xlabel('f[Hz]')
        ylabel('Magnitude |X|')
        title("DFT do sinal - Y");
        hold on

        subplot(3,3,8);
        plot(f, dft_sem_tendY(:));
        xlabel('f[Hz]')
        ylabel('Magnitude |X|')
        title("DFT do sinal sem tendencia - Y");
        hold on

        %Z
        subplot(3,3,3);
        plot(t1, sinalZ);
        xlabel('t[s]')
        ylabel('Amplitude')
        title("Sinal original - Z");
        hold on

        subplot(3,3,6);
        plot(f, dft_com_tendZ(:));
        xlabel('f[Hz]')
        ylabel('Magnitude |X|')
        title("DFT do sinal - Z");
        hold on

        subplot(3,3,9);
        plot(f, dft_sem_tendZ(:));
        xlabel('f[Hz]')
        ylabel('Magnitude |X|')
        title("DFT do sinal sem tendencia - Z");
        hold on
    end
end