addpath(".\公共函数\");
% cla(app.UIAxes);
app.nodeData = RWnodes_coordinates("C:\Users\13206\Documents\MATLAB\LUCapp开发\3角形3节点单元有限元计算\数据集\2elementsnodes.txt");

if app.mode_flag == 4
    addpath(".\4边形4节点单元有限元计算\");
    app.eleData = RWelements(app.File_elementFile);
    parfor i = 1:size(app.eleData,1)
        [~,globe_xy] = find_globe(i,app.eleData,app.nodeData);
        x = globe_xy(:,1);
        y = globe_xy(:,2);
        x_spc = [x(1),x(app.mode_flag)];
        y_spc = [y(1),y(app.mode_flag)];
        % rowname = string(rowIdx);
        hold(app.UIAxes,"on")
        scatter(app.UIAxes,x,y,16,"red");

        plot(app.UIAxes,x(1:2),y(1:2),'Color',[0.5 0.5 0.5]);
        plot(app.UIAxes,x(2:3),y(2:3),'Color',[0.5 0.5 0.5]);
        plot(app.UIAxes,x(3:4),y(3:4),'Color',[0.5 0.5 0.5]);
        plot(app.UIAxes,x_spc,y_spc,'Color',[0.5 0.5 0.5]);
        hold(app.UIAxes,'off')
    end
    rmpath(".\4边形4节点单元有限元计算\");
elseif app.mode_flag == 3
    addpath(".\3角形3节点单元有限元计算\");
    app.eleData = RWelements("C:\Users\13206\Documents\MATLAB\LUCapp开发\3角形3节点单元有限元计算\数据集\2elements.txt");
    parfor i = 1:size(app.eleData,1)
        [~,globe_xy] = find_globe(i,app.eleData,app.nodeData);
        x = globe_xy(:,1);
        y = globe_xy(:,2);
        x_spc = [x(1),x(app.mode_flag)];
        y_spc = [y(1),y(app.mode_flag)];
        % rowname = string(rowIdx);
        hold(app.UIAxes,"on")
        scatter(app.UIAxes,x,y,16,"red");

        plot(app.UIAxes,x(1:2),y(1:2),'Color',[0.5 0.5 0.5]);
        plot(app.UIAxes,x(2:3),y(2:3),'Color',[0.5 0.5 0.5]);
        plot(app.UIAxes,x_spc,y_spc,'Color',[0.5 0.5 0.5]);
        hold(app.UIAxes,'off')
    end
    rmpath(".\3角形3节点单元有限元计算\");
end
rmpath(".\公共函数\");
