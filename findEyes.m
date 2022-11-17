function eyes = findEyes(eyemapped)

eyemappedB = eyemapped > 175;

stats = regionprops(eyemappedB, 'Centroid', 'Circularity');
stats = struct2table(stats);
stats = sortrows(stats, 'Circularity', 'descend');
stats = table2array(stats)

centroids = stats(1:2,:);
l = struct("x", floor(centroids(1,1)), "y", floor(centroids(1,2)));
r = struct("x", floor(centroids(2,1)), "y", floor(centroids(2,2)));
eyes = struct("l", l, "r", r);
end