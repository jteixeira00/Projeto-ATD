function [spm_x, spm_y, spm_z] = stepsPerMinute(x_signalDFT, y_signalDFT, z_signalDFT, activitySize)
    N = activitySize;   %o periodo, N é igual ao numero de amostras
    fs = 50;             %frequencia de amostragem, em Hz
    if (mod(N,2)==0)
        f = -fs/2:fs/N:fs/2-fs/N;
    else
        f = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
    end
    
    % frequencias positivas apenas
    newf = f(f>0);
    
    %dft das frequencias positivas apenas
    x_signalDFT = x_signalDFT(f> 0);
    y_signalDFT = y_signalDFT(f> 0);
    z_signalDFT = z_signalDFT(f> 0);
    
    %achar picos do sinal
    peaks_x = findpeaks(x_signalDFT);
    peaks_y = findpeaks(y_signalDFT);
    peaks_z = findpeaks(z_signalDFT);
    
    %maior desses picos
    max_peak_x =max(peaks_x);
    max_peak_y =max(peaks_y);
    max_peak_z =max(peaks_z);
    
    %definir um threshold de 40% desse maximo
    threshold = 0.4;
    threshold_x = max_peak_x*threshold;
    threshold_y = max_peak_y*threshold;
    threshold_z = max_peak_z*threshold;
    
    peak_array_x = peaks_x(peaks_x > threshold_x);
    peak_array_y = peaks_y(peaks_y > threshold_y);
    peak_array_z = peaks_z(peaks_z > threshold_z);

    % a primeira dessas frequencias é passos por segundo
    spm_x = newf(x_signalDFT == peak_array_x(1))*60;
    spm_y = newf(y_signalDFT == peak_array_y(1))*60;
    spm_z = newf(z_signalDFT == peak_array_z(1))*60;

%     % saber a posiçao onde a frequencia com maior magnitude esta presente
%     [x_maior_valor, x_maior_ind] = max(x_signalDFT);
%     [y_maior_valor, y_maior_ind] = max(y_signalDFT);
%     [z_maior_valor, z_maior_ind] = max(z_signalDFT);
%     
%     % tirar a dita frequencia, que nos dá o numero de passos por segundo
%     sps_x = abs(f(x_maior_ind));
%     sps_y = abs(f(y_maior_ind));
%     sps_z = abs(f(z_maior_ind));
%     
%     %passar para passos por minuto
%     spm_x = 60*sps_x;
%     spm_y = 60*sps_y;
%     spm_z = 60*sps_z;
end