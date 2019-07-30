clear; clc; close all;
wkdir = '../'; % The root foler of FM-Bench
addpath([wkdir 'vlfeat-0.9.21/toolbox/']);
vl_setup;

% Datasets = {'TUM', 'KITTI', 'Tanks_and_Temples', 'CPC'};
Datasets = {'KITTI'};

matcher='SIFT-RT'; % SIFT with Ratio Test
estimator='RANSAC';

for s = 1 : length(Datasets)
     dataset = Datasets{s};
    
    % An example for DoG detector
    FeatureDetection(wkdir, dataset);
    
    % An example for SIFT descriptor
    FeatureExtraction(wkdir, dataset);
   
    % An example for exhaustive nearest neighbor matching with ratio test
    FeatureMatching(wkdir, dataset, matcher);
    
    % An example for RANSAC based FM estimation
    GeometryEstimation(wkdir, dataset, matcher, estimator);
    
end


