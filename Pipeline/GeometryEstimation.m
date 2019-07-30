function GeometryEstimation(wkdir, dataset, matcher, estimator)
% Matching descriptors and save results
disp('Running FM estimation...');

dataset_dir = [wkdir 'Dataset/' dataset '/'];
matches_dir = [wkdir 'Matches/' dataset '/'];

results_dir = [wkdir 'Results/' dataset '/'];
if exist(results_dir, 'dir') == 0
    mkdir(results_dir);
end

pairs_gts = dlmread([dataset_dir 'pairs_with_gt.txt']);
pairs_which_dataset = importdata([dataset_dir 'pairs_which_dataset.txt']);

pairs = pairs_gts(:,1:2);
l_pairs = pairs(:,1);
r_pairs = pairs(:,2);
F_gts = pairs_gts(:,3:11);

load([matches_dir matcher '.mat']);
Results = Matches;
num_pairs = size(pairs,1);

for idx = 1 : num_pairs
    l = l_pairs(idx);
    r = r_pairs(idx);
    
    Results{idx}.dataset = dataset;
    Results{idx}.subset = pairs_which_dataset{idx};
    Results{idx}.l = l;
    Results{idx}.r = r;
    Results{idx}.F_gt = reshape(F_gts(idx,:), 3, 3)';
    
    X_l = Results{idx}.X_l;
    X_r = Results{idx}.X_r;
    
    F_hat = [];
    inliers = [];
    status = 3; % 0 stands for good, others are bad estimations.
    
    try
        [F_hat, inliers, status] = estimateFundamentalMatrix(X_l, X_r, 'Method','RANSAC', 'NumTrials', 2000);
    catch
        disp('Estimation Crash');
    end
    
    Results{idx}.F_hat = F_hat;
    Results{idx}.inliers = inliers;
    Results{idx}.status = status;
end

results_file = [results_dir matcher '-' estimator '.mat'];
save(results_file, 'Results');

disp('Finished.');
end