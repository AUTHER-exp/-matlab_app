function P = solveP(xmaxlist,eleData,nodeData,xmaxelelist,xn)
syms n


%广播变量
%输入高斯积分参数
[G_point,G_H] = choosegauss(xn);
%初始化P矩阵
P=zeros(size(nodeData,1)*2,1);
%应力参数
qx = 7;
qy = 0;


for i=1:length(xmaxelelist)
    Pn=[0 0];
    row = xmaxelelist(i);
    %生成单元节点列表和整体坐标矩阵
    [elelist,globe_xy] = find_globe(row,eleData,nodeData);
    %为节点赋予局部坐标
    part_xy = find_part(globe_xy);

    %
    J = zeros(1,2);
    for i2 = 1:4
        %组装Ni方程
        N = (1+part_xy(i2,1)*1)*(1+part_xy(i2,2)*n)*0.25;

        %Ni方程针对不同方向进行求导
        N_n = diff(N,n);

        %J的x、y对yita偏导环节
        J(1) = J(1) + N_n  * globe_xy(i2,1);
        J(2) = J(2) + N_n  * globe_xy(i2,2);
    end
    %计算L*dm
    L = double((J(1)^2+J(2)^2)^0.5);

    %
    N2 = (1-n)/2;
    N3 = (1+n)/2;

    %
    for i3 = 1:length(G_H)
        num_n = G_point(i3);
        Pn(1) = Pn(1) + subs(G_H(i3) * N2 * qx * 20 * L,n,num_n);
        Pn(2) = Pn(2) + subs(G_H(i3) * N3 * qy * 20 * L,n,num_n);
    end

    %组装P
    for i4 = 1:length(xmaxlist)
        a = xmaxlist(i4);
        for i5 = 1:length(elelist)
            b = elelist(i5);
            if a == b
                P(a*2-1) = P(a*2-1) + Pn(1);
                P(a*2) = P(a*2) + Pn(2);
                elelist(i5) = inf;
            else
                continue
            end
        end
    end
end



