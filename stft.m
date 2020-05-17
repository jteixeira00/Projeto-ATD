function stft(data)
    fs = 50;
    Ts = 1/fs;
    data = data{:,:};
    N = numel(data);
    
    t = N*Ts; % Nao percebo esta linha
    Tframe = 0.0015*t;
    
    Toverlap = Tframe/2;
    
    Nframe = round(Tframe*fs);
    Noverlap = round(Toverlap*fs);

    h = hamming(Nframe);
    
    f_frame = linspace(-fs/2, fs/2, Nframe);
    x = find(f_frame>=0);
    res = [];
    for ii = 1:Nframe-Noverlap:N-Nframe
        data_frame = data(ii:ii+Nframe-1).*h;
        m_data_frame = abs(fftshift(fft(data_frame)));
        res = horzcat(res, m_data_frame(x));    
    end
    
    figure();
    waterfall(20*log10(res))
    figure();
    imagesc(20*log10(res))
    
end

