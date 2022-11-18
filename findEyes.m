function eyes = findEyes(eyemapped)

thresh = 230;
numEyes = 0;
while numEyes < 2
    eyemappedB = eyemapped > thresh;
    thresh = thresh - 10;

    stats = regionprops(eyemappedB, 'Centroid', 'Circularity');
    stats = struct2table(stats);
    stats = sortrows(stats, 'Circularity', 'descend');
    stats = table2array(stats);
    numEyes = length(stats);
end

centroids = stats(1:2,:);
l = struct("x", floor(centroids(1,1)), "y", floor(centroids(1,2)));
r = struct("x", floor(centroids(2,1)), "y", floor(centroids(2,2)));
eyes = struct("l", l, "r", r);
end