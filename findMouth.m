function mouth = findMouth(mouthMapped)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
level = 50;
numMouths = 10;

while numMouths > 1
    
    levelplus = level/255;
    mouth = imbinarize(mouthMapped, levelplus);
    stats = regionprops(mouth, 'BoundingBox');
    numMouths = length(stats);
    
    level = level + 5;
end


box = stats(1).BoundingBox;
x = (box(1) + box(3)/2);
y = (box(2) + box(4)/2);

mouth = struct("x", x, "y", y);
end

