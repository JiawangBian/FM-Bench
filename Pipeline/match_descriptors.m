function [X1, X2] = match_descriptors(f1, f2, d1, d2)

[idxs12, D] = knnsearch(d2, d1, 'K', 2, 'NSMethod', 'exhaustive');

idx1 = 1:size(d1, 1);
idx2 = idxs12(:,1);

matches = uint32([idx1', idx2]);
X1 = f1(matches(:,1),1:2);
X2 = f2(matches(:,2),1:2);

dist_ratios = D(:,1)./D(:,2);

mask = dist_ratios < 0.8;
X1 = X1(mask,:);
X2 = X2(mask,:);

end

