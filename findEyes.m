function eyes = findEyes(eyemapped)

eyemappedB = eyemapped > 200;
imshow(eyemappedB)

stats = regionprops(eyemappedB, 'Centroid')
centroids = cat(1,stats.Centroid)
eyes = struct("l", floor(centroids(1,:)), "r", floor(centroids(2,:)));
end