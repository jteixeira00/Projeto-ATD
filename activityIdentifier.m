function [] = activityIdentifier(datas, dataLabelss)

    max_dft_dynamic = [];
    max_dft_static = [];
    max_dft_transition = [];
    
    for j=1:numel(datas)
        data = cell2mat(datas(j));
        dataLabels = cell2mat(dataLabelss(j));
    
        figureID_dynamic = figure("Name", "Atividades dinamicas",'NumberTitle','off');
        figureID_static = figure("Name", "Atividades estaticas",'NumberTitle','off');
        figureID_transition = figure("Name", "Atividades de transi�ao",'NumberTitle','off');

        for i=1:length(dataLabels)
           start = dataLabels(i,4);     %indice do inicio da atividade
           finish = dataLabels(i,5);    %indice do fim da atividade
           switch dataLabels(i,3)
               case 1  
                        showPlot = true;
                        [max_dft_x, max_dft_y, max_dft_z] = plotDynamicActivities(data, start, finish, 1, figureID_dynamic, showPlot);
                        max_dft_dynamic = [max_dft_dynamic, max_dft_x, max_dft_y, max_dft_z];
               case 2
                        showPlot = true;
                        [max_dft_x, max_dft_y, max_dft_z] = plotDynamicActivities(data, start, finish, 2, figureID_dynamic, showPlot);
                        max_dft_dynamic = [max_dft_dynamic, max_dft_x, max_dft_y, max_dft_z];
               case 3
                        showPlot = true;
                        [max_dft_x, max_dft_y, max_dft_z] = plotDynamicActivities(data, start, finish, 3, figureID_dynamic, showPlot);
                        max_dft_dynamic = [max_dft_dynamic, max_dft_x, max_dft_y, max_dft_z];
               case 4
                        showPlot = false;
                        [max_dft_x, max_dft_y, max_dft_z] = plotStaticActivities(data, start, finish, 4, figureID_static, showPlot);
                        max_dft_static = [max_dft_static, max_dft_x, max_dft_y, max_dft_z];
               case 5
                        showPlot = false;
                        [max_dft_x, max_dft_y, max_dft_z] = plotStaticActivities(data, start, finish, 5, figureID_static, showPlot);
                        max_dft_static = [max_dft_static, max_dft_x, max_dft_y, max_dft_z];
               case 6
                        showPlot = false;
                        [max_dft_x, max_dft_y, max_dft_z] = plotStaticActivities(data, start, finish, 6, figureID_static, showPlot);
                        max_dft_static = [max_dft_static, max_dft_x, max_dft_y, max_dft_z];
               case 7
                        showPlot = false;
                        [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 7, figureID_transition, showPlot);
                        max_dft_transition = [max_dft_transition, max_dft_x, max_dft_y, max_dft_z];
               case 8
                        showPlot = false;
                        [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 8, figureID_transition, showPlot);
                        max_dft_transition = [max_dft_transition, max_dft_x, max_dft_y, max_dft_z];
               case 9
                        showPlot = false;
                        [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 9, figureID_transition, showPlot);
                        max_dft_transition = [max_dft_transition, max_dft_x, max_dft_y, max_dft_z];
               case 10
                        showPlot = false;
                        [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 10, figureID_transition, showPlot);
                        max_dft_transition = [max_dft_transition, max_dft_x, max_dft_y, max_dft_z];
               case 11
                        showPlot = false;
                        [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 11, figureID_transition, showPlot);
                        max_dft_transition = [max_dft_transition, max_dft_x, max_dft_y, max_dft_z];
               case 12
                        showPlot = false;
                        [max_dft_x, max_dft_y, max_dft_z] = plotTransitionActivities(data, start, finish, 12, figureID_transition, showPlot);
                        max_dft_transition = [max_dft_transition, max_dft_x, max_dft_y, max_dft_z];
           end   
        end
    
    end
    
    
    max_dft_dynamic = rmoutliers(max_dft_dynamic);
    max_dft_static = rmoutliers(max_dft_static);
    max_dft_transition = rmoutliers(max_dft_transition);

    media_max_dft_dynamics = mean(max_dft_dynamic);
    media_max_dft_static = mean(max_dft_static);
    media_max_dft_transition = mean(max_dft_transition);

    std_max_dft_dynamics = std(max_dft_dynamic);
    std_max_dft_static = std(max_dft_static);
    std_max_dft_transition = std(max_dft_transition);

    disp("Dynamics - " + media_max_dft_dynamics + " +/- " + std_max_dft_dynamics);
    disp("Static - " + media_max_dft_static + " +/- " + std_max_dft_static);
    disp("Transition - " + media_max_dft_transition + " +/- " + std_max_dft_transition);

end