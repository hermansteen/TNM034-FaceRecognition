function eyes = findEyes(eyemapped)

eyemappedB = eyemapped > 200;
imshow(eyemappedB)

stats = regionprops(eyemappedB, 'Centroid')
centroids = cat(1,stats.Centroid)
l = struct("x", floor(centroids(1,1)), "y", floor(centroids(1,2)));
r = struct("x", floor(centroids(1,2)), "y", floor(centroids(2,2)));
eyes = struct("l", l, "r", r);
end