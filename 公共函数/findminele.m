function [xminlist,xminelelist] = findminele(nodeData,eleData)
% 提取第一列的数据
firstColumn = nodeData(:, 1);

firstColumn = cell2mat(firstColumn);
minValue = min(firstColumn);
xminlist = [];
for i4=1:length(firstColumn)
    n=firstColumn(i4);
    if n == minValue
        xminlist(end+1) = i4;
    else
        continue
    end
end
xminelelist=[];
for i5 = 1:length(xminlist)
    m = xminlist(i5);
    for i6=1:size(eleData,1)
        for i7 = 1:size(eleData,2)
            v = str2double(string(eleData(i6,i7)));
            if v==m
                xminelelist(end+1)=i6;
            else
                continue
            end
        end
    end
end
