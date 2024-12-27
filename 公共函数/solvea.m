function A = solvea(K,P,nodeData,xminlist,mode)

if mode == 1
    % 直接法（可能有误）
    A = zeros(size(P,1),1);
    % 逻辑处理
    % a:选择未知的A_a
    % b:选择已知的A_a
    a = true(size(nodeData,1)*2, 1);
    b = false(size(nodeData,1)*2, 1);

    a(xminlist*2) = false;
    a(xminlist*2-1) = false;
    b(xminlist*2) = true;
    b(xminlist*2-1) = true;

    %得到除位移边界条件的相关矩阵
    Kaa = K(a, a);
    Kbb = K(b, b);
    Kab = K(a, b);
    Kba = K(b, a);
    Pa = P(a);
    % Pb = P(b);

    A(a) = inv(Kaa)*(Pa - Kab*A(b));
    P(b) = Kba*A(a)+Kbb*A(b);
elseif mode == 2
    % 带入边界条件（化一法）
    for i = 1:length(xminlist)
        xmin = xminlist(i);
        % P化零
        P(xmin*2-1) = 0;
        P(xmin*2) = 0;

        % K化零
        K(xmin*2-1,:) = 0;
        K(xmin*2,:) = 0;

        K(:,xmin*2-1) = 0;
        K(:,xmin*2) = 0;

        % 主向量化一
        K(xmin*2 , xmin*2) = 1;
        K(xmin*2-1,xmin*2-1) = 1;

        %全体化一
        % K(xmin*2-1:xmin*2,xmin*2-1:xmin*2) = 1;
        A = K \ P;
    end
end



    % 求解线性方程
    % solution = solve(equation, a);

