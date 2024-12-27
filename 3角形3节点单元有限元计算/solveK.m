function K = solveK(nodeData,eleData)
K=zeros(size(nodeData,1)*2);
for i=1:size(eleData,1)

    [elelist,globe_xy] = find_globe(i,eleData,nodeData);

    Dn = [1 globe_xy(1,1) globe_xy(1,2);
          1 globe_xy(2,1) globe_xy(2,2);
          1 globe_xy(3,1) globe_xy(3,2) ];
    %计算有限元面积A
    A = det(Dn)/2;
 

    c1 = globe_xy(2,2) - globe_xy(3,2);
    c2 = globe_xy(3,2) - globe_xy(1,2);
    c3 = globe_xy(1,2) - globe_xy(2,2);
    d1 = globe_xy(3,1) - globe_xy(2,1);
    d2 = globe_xy(1,1) - globe_xy(3,1);
    d3 = globe_xy(2,1) - globe_xy(1,1);

 
    B = [c1 0   c2 0   c3 0;
         0  d1  0  d2  0  d3;
         d1 c1  d2 c2  d3 c3]/(2*A);
    % D
    D = (210000/(1-0.09))*[1   0.3 0;
                           0.3 1   0; 
                           0   0   0.35];
    %K
    Kn = B'*D*B*20*A;
    for i3 = 1:length(elelist)
        m = elelist(i3);
        K(2*m-1:2*m,2*m-1:2*m) = K(2*m-1:2*m,2*m-1:2*m)+Kn(i3*2-1:i3*2,i3*2-1:i3*2);
        if i3 ~= length(elelist)
            for i4 = i3+1:length(elelist)
                n=elelist(i4);
                K(2*m-1:2*m,2*n-1:2*n) = K(2*m-1:2*m,2*n-1:2*n)+Kn(i3*2-1:i3*2,i4*2-1:i4*2);
            end
        end
        if i3 ~= 1
            for i5 = 1:i3-1
                k = elelist(i5);
                K(2*m-1:2*m,2*k-1:2*k) = K(2*m-1:2*m,2*k-1:2*k)+Kn(i3*2-1:i3*2,i5*2-1:i5*2);
            end
        end
    end
end



