% 读取方法
% 整体节点编号
% rowIdx = 1; 
% 
% xValue = nodeData{rowIdx, 1};
% 
% yValue = nodeData{rowIdx, 2};
% 
% disp(['u值:', num2str(uValue), ' v值:', num2str(vValue)]);

function nodeData = RWnodes_coordinates(x)
filename = x;
% 读取整个文本文件的数据
data = importdata(filename);
% 检查返回的数据类型
% disp(['数据类型: ', class(data)]);
% 如果数据是结构体，访问其.data字段
if isstruct(data) && isfield(data, 'data')
    dataMatrix = data.data;
else
    % 如果数据直接是矩阵，直接使用
    dataMatrix = data;
end
% 获取数据的行数
numRows = size(dataMatrix, 1);
% 创建一个单元数组来存储数据
nodeData = cell(numRows, 2);

% 分选输入的原始参数类型
if size(dataMatrix,2) == 2 %没有第一列的序号

    % 循环遍历每一行
    for i = 1:numRows
        nodeData{i, 1} = dataMatrix(i, 1);
        nodeData{i, 2} = dataMatrix(i, 2);
    end

else
    for i = 1:numRows   %有第一列序号
        nodeData{i, 1} = dataMatrix(i,2);
        nodeData{i, 2} = dataMatrix(i,3);
    end

end

% 清除所有其他变量，只保留nodeData
clearvars -except nodeData eleData





