function mouth = findMouth(mouthMapped)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mouthThresh = 230;
numMouths = 0;

while numMouths < 1
mouthMapp = mouthMapped > mouthThresh/255;
imshow(mouthMapp);
mouthThresh = mouthThresh - 10;

stats = regionprops(mouthMapp, 'Centroid');
stats = struct2table(stats);
%stats = sortrows(stats, 'descend');
stats = table2array(stats);

numMouths = length(stats)

end 

%centroids = cat(1,stats.Centroid);
centroids = stats(:,:);
mouth = struct("x", floor(centroids(1,1)), "y", floor(centroids(1,2)));
end

