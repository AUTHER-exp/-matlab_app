function part_xy = find_part(globe_xy)
    part_xy = zeros(4,2);
    %计算中心点
    centroid = mean(globe_xy, 1);
    % 计算每个点相对于质心的角度
    angles = arrayfun(@(i) atan2d(globe_xy(i, 2) - centroid(2), globe_xy(i, 1) - centroid(1)), 1:size(globe_xy, 1));
    tamps = angles;
    [~,part2] = max(angles);
    tamps(part2) = -inf;
    [~,part1] = max(tamps);
    tamps(part1) = -inf;
    [~,part4] = max(tamps);
    tamps(part4) = -inf;
    [~,part3] = max(tamps);
        %分选坐标
        part_xy(part1,:) =  1;
        part_xy(part2,1) = -1;  part_xy(part2,2) =  1;
        part_xy(part3,:) = -1;
        part_xy(part4,1) =  1;  part_xy(part4,2) = -1;
end