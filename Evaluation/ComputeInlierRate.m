function [inlier_rate, mask] = ComputeInlierRate(F_gt, X1, X2, inliers, size1, size2, threshold)
%COMPUTEINLIERRATE Summary of this function goes here
%   Detailed explanation goes here

t1 = norm(size1) * threshold;
t2 = norm(size2) * threshold;

% t1 = 3;
% t2 = 3;

inliers = reshape(inliers, [length(inliers) 1]); 
inliers = logical(inliers);

X1 = X1';
X2 = X2';

% two epipolar lines
epiLines1 = epipolarLine(F_gt',X2);
epiLines2 = epipolarLine(F_gt, X1);

% distances in two images
d1 = d_from_point_to_line(X1, epiLines1);
d2 = d_from_point_to_line(X2, epiLines2);

% good matches mask
mask = (d1 < t1 & d2 < t2);

before = sum(mask) / length(mask);
after = sum(mask & inliers) / sum(inliers);

inlier_rate = [before after];

end

function distance = d_from_point_to_line(points, lines)
    points(:,3) = 1;
    distance = abs(sum(lines.* points, 2)) ./ (sqrt(sum(lines(:,1:2).^2,2)) + 1e-10);
end