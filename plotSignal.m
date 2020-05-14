function [x, y, z] = plotSignal(data, dataLabels, figureID)
    N = length(data);                   %tamanho dos dados, aka periodo fundamental
    Ts = 1/50; 
    t = linspace(0,Ts*(N-1)/60,N);      %matriz de amostragem, em minutos

    figure(figureID);
    activityIDs = dataLabels(:,3);          %localizados na terceira coluna
    start_time = dataLabels(:,4);           %instantes do inicio da atividade, quarta coluna
    end_time = dataLabels(:,5);             %instantes do fim da atividade, quinta coluna

    %componente X do sinal
    x = data(:,1);
    subplot(3,1,1);
    plot(t, x, 'k');
    xlabel('Minutos')
    ylabel('ACC X')
    hold on

    %componente Y do sinal
    y = data(:,2);
    subplot(3,1,2);
    plot(t, y, 'k');
    xlabel('Minutos')
    ylabel('ACC Y')
    hold on

    %componente Z do sinal
    z = data(:,3);
    subplot(3,1,3);
    plot(t, z, 'k');
    xlabel('Minutos')
    ylabel('ACC Z')
    hold on

    %nomes das atividades para legendar o grafico
    activity_names = ["W", "W U", "W D", "SIT", "STAND", "LAY", "ST 2 SI", "SI 2 ST","SI 2 LIE","LIE 2 SI", "ST 2 LIE", "LIE 2_ST"];

    for i=1:20
        %percorrer as atividades todas
        for j=1:3
            %para cada atividade, dar plot das componentes X, Y e Z
            subplot(3, 1, j);
            plot(t(start_time(i):end_time(i)), data(start_time(i):end_time(i), j));
            
            %legendar plot
            if(mod(i,2) == 0)
                text(start_time(i)/50/60, max(data(:,j))-0.05, activity_names(activityIDs(i)),'FontSize',6); 
            else
                text(start_time(i)/50/60, min(data(:,j))+0.05, activity_names(activityIDs(i)),'FontSize',6);         
            end
            hold on;
        end
    end
end