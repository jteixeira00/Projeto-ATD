clear all;

labels = importlabels("Dados\labels.txt");
data51 = importdata("Dados\acc_exp51_user25.txt");
% data52 = importdata("Dados\acc_exp52_user26.txt");
% data53 = importdata("Dados\acc_exp53_user26.txt");
% data54 = importdata("Dados\acc_exp54_user27.txt");
% data55 = importdata("Dados\acc_exp55_user27.txt");
% data56 = importdata("Dados\acc_exp56_user28.txt");
% data57 = importdata("Dados\acc_exp57_user28.txt");
% data58 = importdata("Dados\acc_exp58_user29.txt");
% data59 = importdata("Dados\acc_exp59_user29.txt");
% data60 = importdata("Dados\acc_exp60_user30.txt");
info_labels = ["W", "W U", "W D", "SIT", "STAND", "LAY", "ST 2 SI", "SI 2 ST","SI 2 LIE","LIE 2 SI", "ST 2 LIE", "LIE 2_ST"];


nFicheiros = cell(1,10);
labels = labels{:,:};

N = height(data51); %tamanho dos dados
fs = 50;
Ts = 1/50; 
t = linspace(0,Ts*(N-1)/60,N); 
    
figure(1);
data51 = data51{:,:};
ids = labels(1:20,3);
start_time = labels(1:20,4);
end_time = labels(1:20,5);

subplot(3,1,1);
plot(t, data51(:,1), 'k');
xlabel('Min')
ylabel('ACC X')
hold on

subplot(3,1,2);
plot(t, data51(:,2), 'k');
xlabel('Min')
ylabel('ACC Y')
hold on

subplot(3,1,3);
plot(t, data51(:,3), 'k');
xlabel('Min')
ylabel('ACC Z')
hold on


for i=1:20
    for j=1:3
        figure(1);
        subplot(3, 1, j);
        
        plot(t(start_time(i):end_time(i)), data51(start_time(i):end_time(i), j));
        if(mod(i,2) == 0)
            text(start_time(i)/50/60, max(data51(:,j))-0.05, info_labels(ids(i)),'FontSize',6); 
        else
            text(start_time(i)/50/60, min(data51(:,j))+0.05, info_labels(ids(i)),'FontSize',6);         
        end
        hold on;
    end
end

sinalX = data51(start_time(1):end_time(1), 1); %Canal X da primeira atividade
sinalY = data51(start_time(1):end_time(1), 2); %Canal Y
sinalZ = data51(start_time(1):end_time(1), 3); %Canal Z
N = length(sinalX); %tamanho dos dados
%vetor de frequencias
if(mod(N,2)==0)
    f = -fs/2 : fs/N : fs/2-fs/N;
else
    f = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
end

t1 = linspace(0,Ts*(N-1)/60,N); 
dft_sem_tendX = abs(fftshift(fft(detrend(sinalX)))); %detrend = tirar tendencia
dft_com_tendX = abs(fftshift(fft(sinalX)));
dft_sem_tendY = abs(fftshift(fft(detrend(sinalY)))); %detrend = tirar tendencia
dft_com_tendY = abs(fftshift(fft(sinalY)));
dft_sem_tendZ = abs(fftshift(fft(detrend(sinalZ)))); %detrend = tirar tendencia
dft_com_tendZ = abs(fftshift(fft(sinalZ)));

figure()
subplot(3,1,1);
plot(t1, sinalX);
xlabel('t[s]')
ylabel('Amplitude')
title("Sinal original");
hold on

subplot(3,1,2);
plot(f, dft_com_tendY(:));
xlabel('f[Hz]')
ylabel('Magnitude |X|')
title("DFT do sinal");
hold on

subplot(3,1,3);
plot(f, dft_sem_tendX(:));
xlabel('f[Hz]')
ylabel('Magnitude |X|')
title("DFT do sinal sem tendencia");
hold on

%axis tight;



aac_x = data51(:,1);
aac_y = data51(:,2);
aac_z = data51(:,3);

search = labels(labels(:,1)== 51,:);

%janelas com trend

% for i=1:length(search)
%     %hamming
%     slicedWindow = search(i,4):search(i,5);
%     tit = info_labels(search(i,3));
%     windowSize=search(i,5)-search(i,4)+1;
%     hammingWindow = hamming(length(slicedWindow));
%    
%     aac_x_mod = abs(fftshift(fft(aac_x(slicedWindow(1):slicedWindow(end),:)))).*hammingWindow;
%     aac_y_mod = abs(fftshift(fft(aac_y(slicedWindow(1):slicedWindow(end),:)))).*hammingWindow;
%     aac_z_mod = abs(fftshift(fft(aac_z(slicedWindow(1):slicedWindow(end),:)))).*hammingWindow;
%     t1 = linspace(0,Ts*(windowSize-1)/60,windowSize)';
%     figure('NumberTitle', 'off', 'Name', tit);
%     subplot(3,3, 1);
%     plot(t1, aac_x_mod);
%     title(tit + ' X ')
%     subplot(3,3, 2);
%     plot(t1, aac_y_mod);
%     title(tit + ' Y ')
%     subplot(3,3, 3);
%     plot(t1, aac_z_mod);
%     title(tit + ' Z ');
%     
%     
%     %hann  
%     hannWindow = hann(length(slicedWindow));
%     aac_x_mod = abs(fftshift(fft(aac_x(slicedWindow(1):slicedWindow(end),:)))).*hannWindow;
%     aac_y_mod = abs(fftshift(fft(aac_y(slicedWindow(1):slicedWindow(end),:)))).*hannWindow;
%     aac_z_mod = abs(fftshift(fft(aac_z(slicedWindow(1):slicedWindow(end),:)))).*hannWindow;
%     subplot(3,3, 4);
%     plot(t1, aac_x_mod);
%     title(tit + ' X ')
%     subplot(3,3, 5);
%     plot(t1, aac_y_mod);
%     title(tit + ' Y ')
%     subplot(3,3, 6);
%     plot(t1, aac_z_mod);
%     title(tit + ' Z ');
%     
%     %hann  
%     blackmanWindow = blackman(length(slicedWindow));
%     aac_x_mod = abs(fftshift(fft(aac_x(slicedWindow(1):slicedWindow(end),:)))).*blackmanWindow;
%     aac_y_mod = abs(fftshift(fft(aac_y(slicedWindow(1):slicedWindow(end),:)))).*blackmanWindow;
%     aac_z_mod = abs(fftshift(fft(aac_z(slicedWindow(1):slicedWindow(end),:)))).*blackmanWindow;
%     
%     subplot(3,3, 7);
%     plot(t1, aac_x_mod);
%     title(tit + ' X ')
%     subplot(3,3, 8);
%     plot(t1, aac_y_mod);
%     title(tit + ' Y ')
%     subplot(3,3, 9);
%     plot(t1, aac_z_mod);
%     title(tit + ' Z ');    
% end



for i=1:length(search)
    
    if(search(i,3)==1)
        slicedWindow = search(i,4):search(i,5);
        windowSize=search(i,5)-search(i,4)+1;
        aac_x_mod = abs(fftshift(fft(detrend(aac_x(slicedWindow(1):slicedWindow(end),:)))));
        
        N = numel(slicedWindow);
        if (mod(N,2)==0)
            f = -fs/2:fs/N:fs/2-fs/N;
        else
            f = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
        end
        figure();
        plot(f, aac_x_mod);
        [x, ind] = max(aac_x_mod);
        y = abs(f(ind));
        spm = 60*y
    end
    
    
end