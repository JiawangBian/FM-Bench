function FeatureMatching(wkdir, dataset, matcher)
% Matching descriptors and save results

dataset_dir = [wkdir 'Dataset/' dataset '/'];
feature_dir = [wkdir 'Features/' dataset '/'];

matches_dir = [wkdir 'Matches/' dataset '/'];
if exist(matches_dir, 'dir') == 0
    mkdir(matches_dir);
end

pairs_gts = dlmread([dataset_dir 'pairs_with_gt.txt']);
pairs_which_dataset = importdata([dataset_dir 'pairs_which_dataset.txt']);

pairs = pairs_gts(:,1:2);
l_pairs = pairs(:,1);
r_pairs = pairs(:,2);

num_pairs = size(pairs,1);
Matches = cell(num_pairs, 1);
for idx = 1 : num_pairs
    l = l_pairs(idx);
    r = r_pairs(idx);
    
    I1 = imread([dataset_dir pairs_which_dataset{idx} 'Images/' sprintf('%.8d.jpg', l)]);
    I2 = imread([dataset_dir pairs_which_dataset{idx} 'Images/' sprintf('%.8d.jpg', r)]);
    
    size_l = size(I1);
    size_l = size_l(1:2);
    size_r = size(I2);
    size_r = size_r(1:2);
    
    path_l = [feature_dir sprintf('%.4d_l', idx)];
    path_r = [feature_dir sprintf('%.4d_r', idx)];
    
    keypoints_l = read_keypoints([path_l '.keypoints']);
    keypoints_r = read_keypoints([path_r '.keypoints']);
    descriptors_l = read_descriptors([path_l '.descriptors']);
    descriptors_r = read_descriptors([path_r '.descriptors']);
    
    [X_l, X_r] = match_descriptors(keypoints_l, keypoints_r, descriptors_l, descriptors_r);
    
    Matches{idx}.size_l = size_l;
    Matches{idx}.size_r = size_r;
    
    Matches{idx}.X_l = X_l;
    Matches{idx}.X_r = X_r;
end

matches_file = [matches_dir matcher '.mat'];
save(matches_file, 'Matches');
end