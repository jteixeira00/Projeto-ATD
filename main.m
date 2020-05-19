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

datas = {data51{:,:}, data52{:,:}, data53{:,:}, data54{:,:}, data55{:,:}, data56{:,:}, data57{:,:}, data58{:,:}, data59{:,:}, data60{:,:}};
dataLabelss = {labels(labels(:,1) == 51,:), labels(labels(:,1) == 52,:), labels(labels(:,1) == 53,:), labels(labels(:,1) == 54,:), labels(labels(:,1) == 55,:), labels(labels(:,1) == 56,:), labels(labels(:,1) == 57,:), labels(labels(:,1) == 58,:), labels(labels(:,1) == 59,:), labels(labels(:,1) == 60,:), };

%escolher UM conjunto de dados (52 neste caso)
data = data52{:,:};
dataLabels = labels(labels(:,1) == 52,:);       %labels desse conjunto

%componentes x, y e z do sinal
[signal_x, signal_y, signal_z] = plotSignal(data, dataLabels, figureID);




%% PREPARAR O SINAL (retirar tendencia e fazer DFT)



showPlot = false;        %escolher se se d� plot da transforma�ao
[dft_x, dft_y, dfy_z] = tratarSinal(signal_x, signal_y, signal_z, showPlot);




%% APLICAR JANELAS


%aplicarJanelasDeslizantes(dataLabels, signal_x, signal_y, signal_z);
aplicarJanelas(dataLabels, signal_x, signal_y, signal_z);




%% DIFERENTES TIPOS DE ATIVIDADE
%Din�micas(1 a 3), est�ticas(4 a 6) e de transi��o(7 a 12)

figureID_dynamic = figure("Name", "Atividades dinamicas",'NumberTitle','off');
figureID_static = figure("Name", "Atividades estaticas",'NumberTitle','off');
figureID_transition = figure("Name", "Atividades de transi�ao",'NumberTitle','off');
figure_3d = figure("Name", "Atividades de transi�ao",'NumberTitle','off');
grid on
hold on

media_atividades_dinamicas = 48.2363;
desvio_padrao_atividades_dinamicas = 27.0347;
media_atividades_dinamicas_lim_superior = media_atividades_dinamicas + desvio_padrao_atividades_dinamicas;
media_atividades_dinamicas_lim_inferior = media_atividades_dinamicas - desvio_padrao_atividades_dinamicas;

figure(figureID_dynamic);
x = linspace(-30, 30);
y1 = media_atividades_dinamicas_lim_superior + zeros(1, length(x));
y2 = media_atividades_dinamicas_lim_inferior + zeros(1, length(x));

for i=1:9
    
 subplot(3,3, i);   
 plot(x, y1);
 hold on
 plot(x, y2);
 hold on;
 
end


media_atividades_estaticas = 2.623;
desvio_padrao_atividades_estaticas = 1.941;
media_atividades_estaticas_lim_superior = media_atividades_estaticas + desvio_padrao_atividades_estaticas;
media_atividades_estaticas_lim_inferior = media_atividades_estaticas - desvio_padrao_atividades_estaticas;

figure(figureID_static);
x = linspace(-30, 30);
y1 = media_atividades_estaticas_lim_superior + zeros(1, length(x));
y2 = media_atividades_estaticas_lim_inferior + zeros(1, length(x));

for i=1:9
    
 subplot(3,3, i);   
 plot(x, y1);
 hold on
 plot(x, y2);
 hold on;
 
end



media_atividades_transicao = 12.203;
desvio_padrao_atividades_transicao = 5.6538;
media_atividades_transicao_lim_superior = media_atividades_transicao + desvio_padrao_atividades_transicao;
media_atividades_transicao_lim_inferior = media_atividades_transicao - desvio_padrao_atividades_transicao;

figure(figureID_transition);
x = linspace(-30, 30);
y1 = media_atividades_transicao_lim_superior + zeros(1, length(x));
y2 = media_atividades_transicao_lim_inferior + zeros(1, length(x));

for i=1:18
    
 subplot(3,6, i);   
 plot(x, y1);
 hold on
 plot(x, y2);
 hold on;
 
end


counters = zeros(1,12);     %para verificar se uma atividade j� foi apresentada no grafico

for j=1:length(datas)
    data = cell2mat(datas(j));
    dataLabels = cell2mat(dataLabelss(j));
    for i=1:length(dataLabels)
       start = dataLabels(i,4);     %indice do inicio da atividade
       finish = dataLabels(i,5);    %indice do fim da atividade

       switch dataLabels(i,3)
           case 1  
                if(counters(1) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotDynamicActivities(data, start, finish, 1, figureID_dynamic, showPlot);
                    figure(figure_3d);
                    p1 = plot3(max_dft_x, max_dft_y, max_dft_z,'o','MarkerEdgeColor',[1 0 0],'DisplayName','WALKING');
                    hold on
                    %counters(1) = 1;    %Para nao repetir o plot da atividade
                end
           case 2
               if(counters(2) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotDynamicActivities(data, start, finish, 2, figureID_dynamic, showPlot);
                    figure(figure_3d);
                    p2 = plot3(max_dft_x, max_dft_y, max_dft_z,'o','MarkerEdgeColor',[0 1 0],'DisplayName','WALKING UP');
                    hold on
                    %counters(2) = 1;    %Para nao repetir o plot da atividade
               end
           case 3
               if(counters(3) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotDynamicActivities(data, start, finish, 3, figureID_dynamic, showPlot);
                    figure(figure_3d);
                    p3 = plot3(max_dft_x, max_dft_y, max_dft_z,'o','MarkerEdgeColor',[0 0 1],'DisplayName','WALKING DOWN');
                    hold on
                    %counters(3) = 1;    %Para nao repetir o plot da atividade
               end
           case 4
               if(counters(4) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotStaticActivities(data, start, finish, 4, figureID_static, showPlot);
                    figure(figure_3d);
                    p4 = plot3(max_dft_x, max_dft_y, max_dft_z,'x','MarkerEdgeColor',[0.2 0.2 0.2],'DisplayName','SITTING');
                    hold on
                    %counters(4) = 1;    %Para nao repetir o plot da atividade
               end
           case 5
               if(counters(5) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotStaticActivities(data, start, finish, 5, figureID_static, showPlot);
                    figure(figure_3d);
                    p5 = plot3(max_dft_x, max_dft_y, max_dft_z,'x','MarkerEdgeColor',[1 0 1],'DisplayName','STANDING');
                    hold on
                    %counters(5) = 1;    %Para nao repetir o plot da atividade
               end
           case 6
               if(counters(6) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotStaticActivities(data, start, finish, 6, figureID_static, showPlot);
                    figure(figure_3d);
                    p6 = plot3(max_dft_x, max_dft_y, max_dft_z,'x','MarkerEdgeColor',[0 1 1],'DisplayName','LAYING');
                    hold on
                    %counters(6) = 1;    %Para nao repetir o plot da atividade
               end
           case 7
               if(counters(7) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 7, figureID_transition, showPlot);
                    figure(figure_3d);
                    p7 = plot3(max_dft_x, max_dft_y, max_dft_z,'d','MarkerEdgeColor',[0.5 0.5 0.5],'DisplayName','STAND_TO_SIT');
                    hold on
                    %counters(7) = 1;    %Para nao repetir o plot da atividade
               end
           case 8
               if(counters(8) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 8, figureID_transition, showPlot);
                    figure(figure_3d);
                    p8 = plot3(max_dft_x, max_dft_y, max_dft_z,'d','MarkerEdgeColor',[0 0 0],'DisplayName','SIT_TO_STAND');
                    hold on
                    %counters(8) = 1;    %Para nao repetir o plot da atividade
               end
           case 9
               if(counters(9) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 9, figureID_transition, showPlot);
                    figure(figure_3d);
                    p9 = plot3(max_dft_x, max_dft_y, max_dft_z,'d','MarkerEdgeColor',[0.5 0 0.5],'DisplayName','SIT_TO_LIE');
                    hold on
                    %counters(8) = 1;    %Para nao repetir o plot da atividade
               end
           case 10
               if(counters(10) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 10, figureID_transition, showPlot);
                    figure(figure_3d);
                    p10 = plot3(max_dft_x, max_dft_y, max_dft_z,'d','MarkerEdgeColor',[0 0.5 0.5],'DisplayName','LIE_TO_SIT');
                    hold on
                    %counters(10) = 1;   %Para nao repetir o plot da atividade
               end
           case 11
               if(counters(11) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 11, figureID_transition, showPlot);
                    figure(figure_3d);
                    p11 = plot3(max_dft_x, max_dft_y, max_dft_z,'d','MarkerEdgeColor',[0.5 0.5 0],'DisplayName','STAND_TO_LIE');
                    hold on
                    %counters(11) = 1;   %Para nao repetir o plot da atividade
               end
           case 12
               if(counters(12) == 0)
                    showPlot = false;
                    [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 12, figureID_transition, showPlot);
                    figure(figure_3d);
                    p12 = plot3(max_dft_x, max_dft_y, max_dft_z,'d','MarkerEdgeColor',[0 0.5 0],'DisplayName','LIE_TO_STAND');
                    hold on
                    %counters(12) = 1;   %Para nao repetir o plot da atividade
               end
       end   
    end

end

h = [p1;p2;p3;p4;p5;p6;p7;p8;p9;p10;p11;p12];
legend(h);

%activityIdentifier(datas, dataLabelss);

%% CALCULO DOS PASSOS POR MINUTO NAS ATIVIDADES DINAMICAS
%fazer media e desvio padrao

%AverageSPM(datas, dataLabelss);


%% STFT
stft(signal_z);
