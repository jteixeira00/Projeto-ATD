function [spm_x, spm_y, spm_z] = stepsPerMinute(x_signalDFT, y_signalDFT, z_signalDFT, activitySize)
    N = activitySize;   %o periodo, N é igual ao numero de amostras
    fs = 50;             %frequencia de amostragem, em Hz
    if (mod(N,2)==0)
        f = -fs/2:fs/N:fs/2-fs/N;
    else
        f = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
    end

    % saber a posiçao onde a frequencia com maior magnitude esta presente
    [~, x_ind] = max(x_signalDFT);
    [~, y_ind] = max(y_signalDFT);
    [~, z_ind] = max(z_signalDFT);
    
    % tirar a dita frequencia, que nos dá o numero de passos por segundo
    sps_x = abs(f(x_ind));
    sps_y = abs(f(y_ind));
    sps_z = abs(f(z_ind));
    
    %passar para passos por minuto
    spm_x = 60*sps_x;
    spm_y = 60*sps_y;
    spm_z = 60*sps_z;
end