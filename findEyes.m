function eyes = findEyes(eyemapped, mouthPosition)

thresh = 200;
numEyes = 0;
[height, width] = size(eyemapped);
eyemapped(floor(mouthPosition.y):height, :) = 0;
while numEyes < 2 && thresh > 0
    eyemappedB = eyemapped > thresh;
    %imshow(eyemappedB)
    eyemappedB = bwpropfilt(eyemappedB, 'Eccentricity', 4, 'smallest');
    eyemappedB = bwpropfilt(eyemappedB, 'Perimeter', [50 inf]);
    eyemappedB = imclearborder(imdilate(eyemappedB, strel('square', 3)));
    %imshow(eyemapped > 200)
    %imshow(eyemappedB);
    %Zero the lower third of image as eyes should not be here
    %This part may not be required, evaluate
    %eyemappedB(yLowerThird:y, :) = 0;
    %[y,x] = size(eyemapped);
    %yLowerThird = (2/3)*y;

    %imshow(eyemappedB);
    %lower threshold for binary eyemap
    thresh = thresh - 10;

    stats = regionprops(eyemappedB, 'Centroid', 'Circularity', 'Perimeter');
    stats = struct2table(stats);
    stats.Roundness = abs(stats.Circularity-1);
    stats = sortrows(stats, 'Roundness', 'ascend');
    toDelete = stats.Roundness > 0.4;
    %Discard roundness values far from perfect circle, perfect circle has
    %roundness = 0
    stats(toDelete, :) = [];
    stats = table2array(stats);
    %find number of eyes to determine whether to loop
    [numEyes, uselessVariable] = size(stats);
end
%imshow(eyemappedB);

centroids = stats(1:2,:);
l = struct("x", floor(centroids(1,1)), "y", floor(centroids(1,2)));
r = struct("x", floor(centroids(2,1)), "y", floor(centroids(2,2)));
eyes = struct("l", l, "r", r);
end