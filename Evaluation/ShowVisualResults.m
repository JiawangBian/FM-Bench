clear; close all; clc;

% TUM
% KITTI
% Tanks_and_Temples
% CPC

method = 'SIFT-RT-RANSAC';
dataset = 'TUM';

results_dir = ['../Results/' dataset '/'];

Results = importdata([results_dir method '.mat']);

idx = 200;

subsets = importdata(['../Dataset/' dataset  '/pairs_which_dataset.txt']);
subset = subsets{idx};

images_dir = ['../Dataset/' dataset '/' subset 'Images/'];
cameras = importdata(['../Dataset/' dataset '/' subset 'Camera.txt']);
poses = importdata(['../Dataset/' dataset '/' subset 'Poses.txt']);

%
status = Results{idx}.status;
l = Results{idx}.l;
r = Results{idx}.r;
X1 = Results{idx}.X_l;
X2 = Results{idx}.X_r;
inliers = Results{idx}.inliers;
F_gt = Results{idx}.F_gt;
F_hat = Results{idx}.F_hat;
size1 = Results{idx}.size_l;
size2 = Results{idx}.size_r;

sgd = Results{idx}.sgd_error
rate = Results{idx}.inlier_rate

% read images
I1 = imread([images_dir sprintf('%.8d.jpg', l)]);
I2 = imread([images_dir sprintf('%.8d.jpg', r)]);

warning('off', 'Images:initSize:adjustingMag');

figure;
showMatchedFeatures(I1, I2, X1, X2, 'montage');
title('Correspondences before RANSAC');

figure;
showMatchedFeatures(I1, I2, X1(inliers,:), X2(inliers,:), 'montage');
title('Correspondences after RANSAC');

% Red lines for GT 
CompareEpipolarLines(F_gt, F_hat, I1, I2, X1', X2', inliers);




