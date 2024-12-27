function draw(nodeData,eleData,a,ax,zoom,mode_flag) %ax 窗口 ； zoom缩放倍率
x_tamp = cell2mat(nodeData(:,1));
y_tamp = cell2mat(nodeData(:,2));

%绘制初始图像
if mode_flag == 4
    for i = 1:size(eleData,1)
        [~,globe_xy] = find_globe(i,eleData,nodeData);
        x = globe_xy(:,1);
        y = globe_xy(:,2);
        x_spc = [x(1),x(mode_flag)];
        y_spc = [y(1),y(mode_flag)];
        % rowname = string(rowIdx);
        scatter(ax,x,y,8,'filled',"red");
        hold(ax,"on");
        plot(ax,x(1:2),y(1:2),'Color',[0.5 0.5 0.5]);
        plot(ax,x(2:3),y(2:3),'Color',[0.5 0.5 0.5]);
        plot(ax,x(3:4),y(3:4),'Color',[0.5 0.5 0.5]);
        plot(ax,x_spc,y_spc,'Color',[0.5 0.5 0.5]);
    end
    %绘制现图像
    for i = 2:2:length(a)
        div_x = a(i-1);
        div_y = a(i);
        x_tamp(i/2) = x_tamp(i/2)+zoom*div_x;
        y_tamp(i/2) = y_tamp(i/2)+zoom*div_y;
    end
    scatter(ax,x_tamp,y_tamp,16,"blue");
    hold(ax,"off");

elseif mode_flag == 3
    for i = 1:size(eleData,1)
        [~,globe_xy] = find_globe(i,eleData,nodeData);
        x = globe_xy(:,1);
        y = globe_xy(:,2);
        x_spc = [x(1),x(mode_flag)];
        y_spc = [y(1),y(mode_flag)];
        % rowname = string(rowIdx);

        scatter(ax,x,y,8,'filled',"red");
        hold(ax,"on");
        plot(ax,x(1:2),y(1:2),'Color',[0.5 0.5 0.5]);
        plot(ax,x(2:3),y(2:3),'Color',[0.5 0.5 0.5]);
        plot(ax,x_spc,y_spc,'Color',[0.5 0.5 0.5]);
    end
        %绘制现图像
    for i = 2:2:length(a)
        div_x = a(i-1);
        div_y = a(i);
        x_tamp(i/2) = x_tamp(i/2)+zoom*div_x;
        y_tamp(i/2) = y_tamp(i/2)+zoom*div_y;
    end
    scatter(ax,x_tamp,y_tamp,16,"blue");
    hold(ax,"off");
end