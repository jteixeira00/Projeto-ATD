close all
clear all;

%% Importar dados e labels

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

%passar de c�lula para matriz
labels = labels{:,:};

%% APRESENTAR SINAL ORIGINAL


figureID = figure("Name", "Sinal",'NumberTitle','off');       %plot para apresentar o sinal original

%escolher UM conjunto de dados (51 neste caso)
datas = {data51{:,:}, data52{:,:}, data53{:,:}, data54{:,:}, data55{:,:}, data56{:,:}, data57{:,:}, data58{:,:}, data59{:,:}, data60{:,:}};
dataLabelss = {labels(labels(:,1) == 51,:), labels(labels(:,1) == 52,:), labels(labels(:,1) == 53,:), labels(labels(:,1) == 54,:), labels(labels(:,1) == 55,:), labels(labels(:,1) == 56,:), labels(labels(:,1) == 57,:), labels(labels(:,1) == 58,:), labels(labels(:,1) == 59,:), labels(labels(:,1) == 60,:), };

data = data55{:,:};
dataLabels = labels(labels(:,1) == 55,:);       %labels desse conjunto

%componentes x, y e z do sinal
[signal_x, signal_y, signal_z] = plotSignal(data, dataLabels, figureID);




%% PREPARAR O SINAL (retirar tendencia e fazer DFT)



showPlot = false;        %escolher se se d� plot da transforma�ao
[dft_x, dft_y, dfy_z] = tratarSinal(signal_x, signal_y, signal_z, showPlot);




%% APLICAR JANELAS


%aplicarJanelasDeslizantes(dataLabels, signal_x, signal_y, signal_z);
%aplicarJanelas(dataLabels, signal_x, signal_y, signal_z);




%% DIFERENTES TIPOS DE ATIVIDADE
%Din�micas(1 a 3), est�ticas(4 a 6) e de transi��o(7 a 12)

figureID_dynamic = figure("Name", "Atividades dinamicas",'NumberTitle','off');
figureID_static = figure("Name", "Atividades estaticas",'NumberTitle','off');
figureID_transition = figure("Name", "Atividades de transi�ao",'NumberTitle','off');


counters = zeros(1,12);     %para verificar se uma atividade j� foi apresentada no grafico
for i=1:length(dataLabels)
   start = dataLabels(i,4);     %indice do inicio da atividade
   finish = dataLabels(i,5);    %indice do fim da atividade
   switch dataLabels(i,3)
       case 1  
            if(counters(1) == 0)
                [x, y, z] = plotDynamicActivities(data, start, finish, 1, figureID_dynamic);
                counters(1) = 1;    %Para nao repetir o plot da atividade
            end
       case 2
           if(counters(2) == 0)
                [x, y, z] = plotDynamicActivities(data, start, finish, 2, figureID_dynamic);
                counters(2) = 1;    %Para nao repetir o plot da atividade
           end
       case 3
           if(counters(3) == 0)
                [x, y, z] = plotDynamicActivities(data, start, finish, 3, figureID_dynamic);
                counters(3) = 1;    %Para nao repetir o plot da atividade
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

%AverageSPM(datas, dataLabelss);

