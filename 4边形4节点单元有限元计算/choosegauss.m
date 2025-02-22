function  [G_point,G_H] = choosegauss(xn)

if xn == 1
    G_point = [0];
    G_H     = [2];
elseif xn == 2
    G_point = [-0.5773503 0.5773503];
    G_H     = [1 1];
elseif xn == 3
    G_point = [-0.7745967 0 0.7745967];
    G_H     = [0.55555556 0.88888889 0.55555556];
elseif xn == 4
    G_point = [0.861136311594053 -0.861136311594053 0.339981043584856 -0.339981043584856];
    G_H     = [0.347854845137454  0.347854845137454 0.652145154862546  0.652145154862546];
end