function mouth = findMouth(mouthMapped)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mouth = mouthMapped > 90/255;
imshow(mouth)

stats = regionprops(mouth, 'Centroid')
centroids = cat(1,stats.Centroid);
mouth = struct("x", floor(centroids(1,1)), "y", floor(centroids(1,2)));
end

