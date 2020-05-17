close all
clear all;

%% Importar dados e labels

labels = importlabels("Dados\labels.txt");
data51 = importdata("Dados\acc_exp51_user25.txt");
data52 = importdata("Dados\acc_exp52_user26.txt");
% data53 = importdata("Dados\acc_exp53_user26.txt");
% data54 = importdata("Dados\acc_exp54_user27.txt");
% data55 = importdata("Dados\acc_exp55_user27.txt");
% data56 = importdata("Dados\acc_exp56_user28.txt");
% data57 = importdata("Dados\acc_exp57_user28.txt");
% data58 = importdata("Dados\acc_exp58_user29.txt");
% data59 = importdata("Dados\acc_exp59_user29.txt");
% data60 = importdata("Dados\acc_exp60_user30.txt");

%passar de c�lula para matriz
labels = labels{:,:};

%% APRESENTAR SINAL ORIGINAL


figureID = figure("Name", "Sinal",'NumberTitle','off');       %plot para apresentar o sinal original

%escolher UM conjunto de dados (51 neste caso)
data = data52{:,:};
dataLabels = labels(labels(:,1) == 52,:);       %labels desse conjunto

%componentes x, y e z do sinal
[signal_x, signal_y, signal_z] = plotSignal(data, dataLabels, figureID);




%% PREPARAR O SINAL (retirar tendencia e fazer DFT)



showPlot = false;        %escolher se se d� plot da transforma�ao
[dft_x, dft_y, dfy_z] = tratarSinal(signal_x, signal_y, signal_z, showPlot);




%% APLICAR JANELAS


aplicarJanelas(dataLabels, signal_x, signal_y, signal_z);




%% DIFERENTES TIPOS DE ATIVIDADE
%Din�micas(1 a 3), est�ticas(4 a 6) e de transi��o(7 a 12)

figureID_dynamic = figure("Name", "Atividades dinamicas",'NumberTitle','off');
figureID_static = figure("Name", "Atividades estaticas",'NumberTitle','off');
figureID_transition = figure("Name", "Atividades de transi�ao",'NumberTitle','off');

%PASSOS POR MINUTO 3x3, uma linha por cada atividade dinamica
spm = zeros(3, 3);

counters = zeros(1,12);     %para verificar se uma atividade j� foi apresentada no grafico
for i=1:length(dataLabels)
   start = dataLabels(i,4);     %indice do inicio da atividade
   finish = dataLabels(i,5);    %indice do fim da atividade
   switch dataLabels(i,3)
       case 1  
            if(counters(1) == 0)
                [x, y, z] = plotDynamicActivities(data, start, finish, 1, figureID_dynamic);
                counters(1) = 1;    %Para nao repetir o plot da atividade
                %calcular os passos por minuto e inserir na matriz
                [spm_x, spm_y, spm_z] = stepsPerMinute(x, y, z, finish-start);
                spm(1,:) = [spm_x, spm_y, spm_z];
            end
       case 2
           if(counters(2) == 0)
                [x, y, z] = plotDynamicActivities(data, start, finish, 2, figureID_dynamic);
                counters(2) = 1;    %Para nao repetir o plot da atividade
                [spm_x, spm_y, spm_z] = stepsPerMinute(x, y, z, finish-start);
                spm(2,:) = [spm_x, spm_y, spm_z];
           end
       case 3
           if(counters(3) == 0)
                [x, y, z] = plotDynamicActivities(data, start, finish, 3, figureID_dynamic);
                counters(3) = 1;    %Para nao repetir o plot da atividade
                [spm_x, spm_y, spm_z] = stepsPerMinute(x, y, z, finish-start);
                spm(3,:) = [spm_x, spm_y, spm_z];
           end
       case 4
           if(counters(4) == 0)
                plotStaticActivities(data, start, finish, 4, figureID_static);
                counters(4) = 1;    %Para nao repetir o plot da atividade
           end
       case 5
           if(counters(5) == 0)
                plotStaticActivities(data, start, finish, 5, figureID_static);
                counters(5) = 1;    %Para nao repetir o plot da atividade
           end
       case 6
           if(counters(6) == 0)
                plotStaticActivities(data, start, finish, 6, figureID_static);
                counters(6) = 1;    %Para nao repetir o plot da atividade
           end
       case 7
           if(counters(7) == 0)
                plotTransitionActivities(data, start, finish, 7, figureID_transition);
                counters(7) = 1;    %Para nao repetir o plot da atividade
           end
       case 8
           if(counters(8) == 0)
                plotTransitionActivities(data, start, finish, 8, figureID_transition);
                counters(8) = 1;    %Para nao repetir o plot da atividade
           end
       case 9
           if(counters(9) == 0)
                plotTransitionActivities(data, start, finish, 9, figureID_transition);
                counters(8) = 1;    %Para nao repetir o plot da atividade
           end
       case 10
           if(counters(10) == 0)
                plotTransitionActivities(data, start, finish, 10, figureID_transition);
                counters(10) = 1;   %Para nao repetir o plot da atividade
           end
       case 11
           if(counters(11) == 0)
                plotTransitionActivities(data, start, finish, 11, figureID_transition);
                counters(11) = 1;   %Para nao repetir o plot da atividade
           end
       case 12
           if(counters(12) == 0)
                plotTransitionActivities(data, start, finish, 12, figureID_transition);
                counters(12) = 1;   %Para nao repetir o plot da atividade
           end
   end   
end

%% CALCULO DOS PASSOS POR MINUTO NAS ATIVIDADES DINAMICAS
%fazer media e desvio padrao

steps_x_w = [];
steps_x_wu = [];
steps_x_wd = [];
steps_y_w = [];
steps_y_wu = [];
steps_y_wd = [];
steps_z_w = [];
steps_z_wu = [];
steps_z_wd = [];

for i = 1:length(dataLabels)
    start = dataLabels(i, 4);
    finish = dataLabels(i, 5);
    data_steps = data(dataLabels(i, 4):dataLabels(i, 5), :);
    switch dataLabels(i, 3)
        case 1
           [signal_steps_x, signal_steps_y, signal_steps_z] = dynamicActivitiesDFT(data_steps); 
           size = dataLabels(i, 5) - dataLabels(i, 4);
           [steps_x, steps_y, steps_z] = stepsPerMinute(signal_steps_x, signal_steps_y, signal_steps_z, size);
           steps_x_w = horzcat(steps_x_w, steps_x);
           steps_y_w = horzcat(steps_y_w, steps_y);
           steps_z_w = horzcat(steps_z_w, steps_z);
        case 2
           [signal_steps_x, signal_steps_y, signal_steps_z] = dynamicActivitiesDFT(data_steps); 
           size = dataLabels(i, 5) - dataLabels(i, 4);
           [steps_x, steps_y, steps_z] = stepsPerMinute(signal_steps_x, signal_steps_y, signal_steps_z, size);
           steps_x_wu = horzcat(steps_x_wu, steps_x);
           steps_y_wu = horzcat(steps_y_wu, steps_y);
           steps_z_wu = horzcat(steps_z_wu, steps_z);
        case 3
           [signal_steps_x, signal_steps_y, signal_steps_z] = dynamicActivitiesDFT(data_steps); 
           size = dataLabels(i, 5) - dataLabels(i, 4);
           [steps_x, steps_y, steps_z] = stepsPerMinute(signal_steps_x, signal_steps_y, signal_steps_z, size);
           steps_x_wd = horzcat(steps_x_wd, steps_x);
           steps_y_wd = horzcat(steps_y_wd, steps_y);
           steps_z_wd = horzcat(steps_z_wd, steps_z);
    end
end

stft(data51(:,3));

%media e desvio padrao
%walking

mean_walking_x = mean(steps_x_w);
mean_walking_y = mean(steps_y_w);
mean_walking_z = mean(steps_z_w);
disp(mean_walking_x);
disp(mean_walking_y);
disp(mean_walking_z);

std_walking_x = std(steps_x_w);
std_walking_y = std(steps_y_w);
std_walking_z = std(steps_z_w);
disp(std_walking_x);
disp(std_walking_y);
disp(std_walking_z);

%walking up

mean_walkingUp_x = mean(steps_x_wu);
mean_walkingUp_y = mean(steps_y_wu);
mean_walkingUp_z = mean(steps_z_wu);
disp(mean_walkingUp_x);
disp(mean_walkingUp_y);
disp(mean_walkingUp_z);

std_walkingUp_x = std(steps_x_wu);
std_walkingUp_y = std(steps_y_wu);
std_walkingUp_z = std(steps_z_wu);
disp(std_walkingUp_x);
disp(std_walkingUp_y);
disp(std_walkingUp_z);

%walking down

mean_walkingDown_x = mean(steps_x_wd);
mean_walkingDown_y = mean(steps_y_wd);
mean_walkingDown_z = mean(steps_z_wd);
disp(mean_walkingDown_x);
disp(mean_walkingDown_y);
disp(mean_walkingDown_z);

std_walkingDown_x = std(steps_x_wd);
std_walkingDown_y = std(steps_y_wd);
std_walkingDown_z = std(steps_z_wd);
disp(std_walkingDown_x);
disp(std_walkingDown_y);
disp(std_walkingDown_z);
