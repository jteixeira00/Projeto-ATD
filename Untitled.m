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
info_labels = ["WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING", "STAND_TO_SIT", "SIT_TO_STAND","SIT_TO_LIE","LIE_TO_SIT", "STAND_TO_LIE", "LIE_TO_STAND"];
nFicheiros = cell(1,10);
labels = labels{:,:};
N = height(data51);
fs = 50;
Ts = 1/50; 
%t = [0:N-1].Ts;
t = linspace(0,Ts*(N-1)/60,N);
    
figure(1)
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
        subplot(3, 1, j);
        plot(t(start_time(i):end_time(i)), data51(start_time(i):end_time(i), j));
        if(mod(i,2) == 0)
            text(start_time(i)/50/60, -0.7, info_labels(ids(i)),'FontSize',6); 
        else
            text(start_time(i)/50/60, 0.7, info_labels(ids(i)),'FontSize',6);         
        end
  
    end
end

if(mod(N,2)==0)
    f = -fs/2:fs/N:fs/2-fs/N;
else
    f = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
end

dft = fftshift(fft(detrend(data51))); %not sure se é preciso dar detrend
dft_ABS = abs(dft);
figure(2);
plot(f, dft_ABS), hold on;
title('|DFT| do sinal');
ylabel('Magnitude = |X|');
xlabel('f [Hz]');
axis tight;

%janela hamming
for(i=
hamm = hamming(
