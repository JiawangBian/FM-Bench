function FeatureExtraction(wkdir, dataset)
% Extract and save SIFT descriptors
disp('Extracting descriptors...');

dataset_dir = [wkdir 'Dataset/' dataset '/'];

feature_dir = [wkdir 'Features/' dataset '/'];
if exist(feature_dir, 'dir') == 0
    mkdir(feature_dir);
end

pairs_gts = dlmread([dataset_dir 'pairs_with_gt.txt']);
pairs_which_dataset = importdata([dataset_dir 'pairs_which_dataset.txt']);

pairs = pairs_gts(:,1:2);
l_pairs = pairs(:,1);
r_pairs = pairs(:,2);

num_pairs = size(pairs,1);
for idx = 1 : num_pairs
    l = l_pairs(idx);
    r = r_pairs(idx);
    
    I1 = imread([dataset_dir pairs_which_dataset{idx} 'Images/' sprintf('%.8d.jpg', l)]);
    I2 = imread([dataset_dir pairs_which_dataset{idx} 'Images/' sprintf('%.8d.jpg', r)]);
    
    if size(I1,3) == 3
        I1gray = rgb2gray(I1);
    else
        I1gray = I1;
    end
    
    if size(I2,3) == 3
        I2gray = rgb2gray(I2);
    else
        I2gray = I2;
    end
    
    path_l = [feature_dir sprintf('%.4d_l', idx)];
    path_r = [feature_dir sprintf('%.4d_r', idx)];
    
    if exist([path_l '.descriptors'], 'file') == 2 && exist([path_r '.descriptors'], 'file') == 2
        continue;
    end
    
    keypoints_l = read_keypoints([path_l '.keypoints']);
    keypoints_r = read_keypoints([path_r '.keypoints']);
    
    % Extract and save features for l
    [~, descriptors_l] = vl_covdet(single(I1gray), 'Frames', keypoints_l', ...
        'Descriptor', 'SIFT');
    
    write_descriptors([path_l '.descriptors'], descriptors_l');
    
    % Extract and save features for r
    [~, descriptors_r] = vl_covdet(single(I2gray), 'Frames', keypoints_r', ...
        'Descriptor', 'SIFT');
    
    write_descriptors([path_r '.descriptors'], descriptors_r');
    
end

disp('Finished.');
end
