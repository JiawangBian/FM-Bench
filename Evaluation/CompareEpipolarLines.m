function [outputArg1,outputArg2] = CompareEpipolarLines(F_gt, F, I1, I2, X1, X2, inliers)
%COMPAREEPIPOLARLINES Summary of this function goes here
%   Detailed explanation goes here

while sum(inliers) > 50
    x = max(1, min(length(inliers),floor(rand() * length(inliers))));
    inliers(x) = 0;    
end


figure; 
subplot(121);
imshow(I1); 
title('Red for GT'); hold on;
plot(X1(1,inliers), X1(2,inliers),'go');
% draw F
epiLines = epipolarLine(F',X2(:,inliers)');
points = lineToBorderPoints(epiLines,size(I1));
line(points(:,[1,3])',points(:,[2,4])', 'color','blue');
% draw F_gt
epiLines = epipolarLine(F_gt',X2(:,inliers)');
points = lineToBorderPoints(epiLines,size(I1));
line(points(:,[1,3])',points(:,[2,4])', 'color','red');



subplot(122); 
imshow(I2);
title('Blue for Estimats'); hold on;
plot(X2(1,inliers),X2(2,inliers),'go');
% draw F
epiLines = epipolarLine(F,X1(:,inliers)');
points = lineToBorderPoints(epiLines,size(I2));
line(points(:,[1,3])',points(:,[2,4])', 'color', 'blue');
% draw F_gt
epiLines = epipolarLine(F_gt,X1(:,inliers)');
points = lineToBorderPoints(epiLines,size(I2));
line(points(:,[1,3])',points(:,[2,4])', 'color', 'red');

end

