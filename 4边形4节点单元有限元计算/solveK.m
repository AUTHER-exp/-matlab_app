function K = solveK(nodeData,eleData,xn)
syms m n 


%广播变量
% 计算D
D = (210000/(1-0.09))*[1 0.3 0;0.3 1 0; 0 0 0.35];
%初始化K矩阵
K=zeros(size(nodeData,1)*2);
%输入高斯积分参数

[G_point,G_H] = choosegauss(xn);


%读取一个unit，找到其中的节点编号
for i=1:size(eleData,1)
    %生成单元节点列表和整体坐标矩阵
    [elelist,globe_xy] = find_globe(i,eleData,nodeData);

    %为节点赋予局部坐标
        part_xy = find_part(globe_xy);
        
        %计算J
        %!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! !!!
        %节点编号有问题
        J = sym(zeros(2));
        for i2 = 1:4
            %组装Ni方程
            N = (1+part_xy(i2,1)*m)*(1+part_xy(i2,2)*n)*0.25;

            %Ni方程针对不同方向进行求导
            N_m = diff(N,m);
            N_n = diff(N,n);

            %组装雅可比行列式
            J(1,1) = J(1,1) + N_m  * globe_xy(i2,1);
            J(1,2) = J(1,2) + N_m  * globe_xy(i2,2);
            
            %J的x、y对yita偏导环节
            J(2,1) = J(2,1) + N_n  * globe_xy(i2,1);
            J(2,2) = J(2,2) + N_n  * globe_xy(i2,2);
        end
        %计算雅可比行列式的数值（目前仍是方程形式）
        fun_J = det(J);
        %雅可比行列式的逆
        inv_J = [J(2,2) -J(1,2); 
                -J(2,1) J(1,1)]/fun_J;


        %计算B
        B = sym(zeros(3,8));
        for i3 = 1:4
            N = (1+part_xy(i3,1)*m)*(1+part_xy(i3,2)*n)*0.25;
            N_m = diff(N,m);
            N_n = diff(N,n);

            %计算每一个节点的Bi矩阵
            Bi = inv_J * [N_m ; N_n];

            %组装B矩阵
            B(1,i3*2-1) = Bi(1);
            B(3,i3*2) = Bi(1);
            B(2,i3*2) = Bi(2);
            B(3,i3*2-1) = Bi(2);

        end
        % 将 B 转换为数值函数句柄
        B_func = matlabFunction(B, 'vars', {m, n});
        num_J_func = matlabFunction(fun_J,'Vars',{m,n});
        %计算Kn
        %处理高斯积分
        %代入计算
        K_n = zeros(8);
        
        % 循环进行计算
        for i4 = 1:xn
            Hp = G_H(i4);
            num_m = G_point(i4);
            for i5 = 1:xn
                Hq = G_H(i5);
                num_n = G_point(i5);
                
                % 计算 B num_J 的数值形式
                B_num = B_func(num_m, num_n);
                num_J = num_J_func(num_m, num_n);
                % 进行数值计算
                K_n_m = Hp * Hq * B_num' * D * B_num * 20 * num_J;
                K_n = K_n + K_n_m;
            end
        end

        % 将结果转换为 double 类型
        K_n = double(K_n);


         %组装K   
    for i6 = 1:length(elelist)
        u = elelist(i6);
        K(2*u-1:2*u,2*u-1:2*u) = K(2*u-1:2*u,2*u-1:2*u)+K_n(i6*2-1:i6*2,i6*2-1:i6*2);
        if i6 ~= length(elelist)
            for i7 = i6+1:length(elelist)
                v=elelist(i7);
                K(2*u-1:2*u,2*v-1:2*v) = K(2*u-1:2*u,2*v-1:2*v)+K_n(i6*2-1:i6*2,i7*2-1:i7*2);
            end
        end
        if i6 ~= 1
            for i8 = 1:i6-1
                k = elelist(i8);
                K(2*u-1:2*u,2*k-1:2*k) = K(2*u-1:2*u,2*k-1:2*k) + K_n(i6*2-1:i6*2,i8*2-1:i8*2);
            end
        end
    end
end

    
