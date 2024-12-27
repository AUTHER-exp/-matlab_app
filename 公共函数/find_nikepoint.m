function [tamplist,p_x,p_y]=find_nikepoint(nodeData,xmaxlist,A)
% 提取第二列的数据
firstColumn = nodeData(:, 2);

%化为可处理浮点数
firstColumn = cell2mat(firstColumn);

% 找到最大值
maxValue = max(firstColumn);
% 初始化最大值节点列表
ymaxlist = [];


for i = 1:length(firstColumn)
    n = firstColumn(i);
    if n == maxValue
        ymaxlist(end+1) = i;
    else
        continue
    end
end

commonlist = intersect(xmaxlist,ymaxlist);
nike_point = commonlist(1);
tamplist = cell2mat(nodeData(nike_point,:));
p_x = tamplist(1)+A(nike_point*2-1);
p_y = tamplist(2)+A(nike_point*2)  ;
