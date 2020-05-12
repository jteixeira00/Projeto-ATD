clear all;

labels = importlabels("Dados\labels.txt");
data51 = importdata("Dados\acc_exp51_user25.txt");
data52 = importdata("Dados\acc_exp52_user26.txt");
data53 = importdata("Dados\acc_exp53_user26.txt");
data54 = importdata("Dados\acc_exp54_user27.txt");
data55 = importdata("Dados\acc_exp55_user27.txt");
data56 = importdata("Dados\acc_exp56_user28.txt");
data57 = importdata("Dados\acc_exp57_user28.txt");
data58 = importdata("Dados\acc_exp58_user29.txt");
data59 = importdata("Dados\acc_exp59_user29.txt");
data60 = importdata("Dados\acc_exp60_user30.txt");
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

sinal = data51(start_time(1):end_time(1), 1); %Canal X da primeira atividade
        
N = length(sinal); %tamanho dos dados
%vetor de frequencias
if(mod(N,2)==0)
    f = -fs/2 : fs/N : fs/2-fs/N;
else
    f = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
end

t1 = linspace(0,Ts*(N-1)/60,N); 
dft_sem_tend = abs(fftshift(fft(detrend(sinal)))); %detrend = tirar tendencia
dft_com_tend = abs(fftshift(fft(sinal)));

figure()
subplot(3,1,1);
plot(t1, sinal);
xlabel('t[s]')
ylabel('Amplitude')
title("Sinal original");
hold on

subplot(3,1,2);
plot(f, dft_com_tend(:));
xlabel('f[Hz]')
ylabel('Magnitude |X|')
title("DFT do sinal");
hold on

subplot(3,1,3);
plot(f, dft_sem_tend(:));
xlabel('f[Hz]')
ylabel('Magnitude |X|')
title("DFT do sinal sem tendencia");
hold on

%axis tight;

%janela hamming

