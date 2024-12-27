% 读取方法
% 整体节点编号
% rowIdx = 1; 
% 
% n1Value = eleData{rowIdx, 1};
% 
% n2Value = eleData{rowIdx, 2};
% 
% n3value = eleData{rowIdx, 3};




function eleData = RWelements(x)
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
eleData = cell(numRows, 4);
if size(dataMatrix,2) == 4
    % 循环遍历每一行
    for i = 1:numRows
        eleData{i, 1} = dataMatrix(i, 1);
        eleData{i, 2} = dataMatrix(i, 2);
        eleData{i, 3} = dataMatrix(i, 3);
        eleData{i, 4} = dataMatrix(i, 4);
    end
else
    % 循环遍历每一行
    for i = 1:numRows
        eleData{i, 1} = dataMatrix(i, 2);
        eleData{i, 2} = dataMatrix(i, 3);
        eleData{i, 3} = dataMatrix(i, 4);
        eleData{i, 4} = dataMatrix(i, 5);
    end
    
end
clearvars -except nodeData eleData
