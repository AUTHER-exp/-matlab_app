function P = solveP(xmaxlist,nodeData,xmaxelelist,eleData)

xmaxelelist = unique(xmaxelelist);
P=zeros((size(nodeData,1)*2),1);
%修改nodeData属性
temp_nodeData = cell2mat(nodeData);
for i = 1:length(xmaxelelist)

    %选取符合条件的单元
    row = xmaxelelist(i);
    %生成单元节点列表和整体坐标矩阵
    [elelist,~] = find_globe(row,eleData,nodeData);

    %找到该单元中有哪些点是边界点
    commonnode = intersect(elelist, xmaxlist);

    %分选，仅参与一次边界均布载荷的点，和参与两次的点

    
    % 单位是kN
    if length(commonnode) == 2
        P(commonnode(1)*2-1,1) = P(commonnode(1)*2-1,1)+abs((20/2)*7*(temp_nodeData(commonnode(1),2)-temp_nodeData(commonnode(2),2)));
        P(commonnode(1)*2  ,1) = P(commonnode(1)*2  ,1)+abs((20/2)*7*(temp_nodeData(commonnode(1),1)-temp_nodeData(commonnode(2),1)));

        P(commonnode(2)*2-1,1) = P(commonnode(2)*2-1,1)+abs((20/2)*7*(temp_nodeData(commonnode(1),2)-temp_nodeData(commonnode(2),2)));
        P(commonnode(2)*2  ,1) = P(commonnode(2)*2  ,1)+abs((20/2)*7*(temp_nodeData(commonnode(1),1)-temp_nodeData(commonnode(2),1)));

    else
        continue
    end
end

