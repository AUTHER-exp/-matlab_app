function [elelist,globe_xy] = find_globe(i,eleData,nodeData)
        rowIdx = i;
    if size(eleData,2) == 4
        % 四节点单元整体节点编号
        n1Value = eleData{rowIdx, 1};
        n2Value = eleData{rowIdx, 2};
        n3Value = eleData{rowIdx, 3};
        n4Value = eleData{rowIdx, 4};
        elelist = [n1Value n2Value n3Value n4Value];
        %为节点找到响应的整体坐标
        %存储矩阵初始化
        globe_xy =  [0 0;0 0;0 0;0 0];
        %储存矩阵组装
        for i1 = 1:length(elelist)
            rowIdx = elelist(i1);
            xValue = nodeData{rowIdx, 1};
            yValue = nodeData{rowIdx, 2};
            globe_xy(i1,1) = xValue;
            globe_xy(i1,2) = yValue;
        end
    elseif size(eleData,2) == 3
        %三边形三节点单元整体节点编写
        n1Value = eleData{rowIdx, 1};
        n2Value = eleData{rowIdx, 2};
        n3Value = eleData{rowIdx, 3};
        elelist = [n1Value n2Value n3Value];
        %为节点找到响应的整体坐标
        %存储矩阵初始化
        globe_xy =  [0 0;0 0;0 0];
        %储存矩阵组装
        for i1 = 1:length(elelist)
            rowIdx = elelist(i1);
            xValue = nodeData{rowIdx, 1};
            yValue = nodeData{rowIdx, 2};
            globe_xy(i1,1) = xValue;
            globe_xy(i1,2) = yValue;
        end
    end