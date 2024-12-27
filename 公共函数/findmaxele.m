function [xmaxlist,xmaxelelist] = findmaxele(nodeData,eleData)
% 提取第一列的数据
firstColumn = nodeData(:, 1);

%化为可处理浮点数
firstColumn = cell2mat(firstColumn);

% 找到最大值
maxValue = max(firstColumn);
% 初始化最大值节点列表
xmaxlist = [];


for i = 1:length(firstColumn)
    n = firstColumn(i);
    if n == maxValue
        xmaxlist(end+1) = i;
    else
        continue
    end
end

%寻找最大节点所在单元
xmaxelelist=[];

for i1 = 1:length(xmaxlist)
    m = xmaxlist(i1);
    for i2 = 1:size(eleData,1)
        for i3 = 1:size(eleData,2)
            v = str2double(string(eleData(i2,i3)));
            if v==m
                xmaxelelist(end+1) = i2;
            else
                continue
            end
        end
    end
end
xmaxelelist = unique(xmaxelelist);