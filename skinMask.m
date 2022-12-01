function mask = skinMask(image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[rows,cols] = size(image);

level = graythresh(image);
level = level - 0.06;

mask = imbinarize(image, level);

temp = (cols-20);
temp2 = (rows - 20);
mask(:, 1:20) = 0;
mask(1:20, :) = 0;
mask(:, temp:cols) = 0;
mask(temp2:rows, :) = 0;

labeledMask = bwlabel(mask, 8);
stats = regionprops(mask, 'EulerNumber', 'BoundingBox', 'Area');

for i = 1:size(stats)
    numberOfHoles = stats(i).EulerNumber;
    box = stats(i).BoundingBox;
    area = stats(i).Area;
    
    width = box(3);
    height = box(4);
    whratio = width/height;
    hwratio = height/width;
    areaRatio = area/(width*height);
    
    if numberOfHoles == 1
        labeledMask(labeledMask == i) = 0;
        continue;
    end
    
    if hwratio < 0.8 || hwratio > 2.0
        labeledMask(labeledMask == i) = 0;
        continue;
    end
    
    if areaRatio < 0
        labeledMask(labeledMask == i) = 0;
        continue;
    end
    
    if area < 1000
        labeledMask(labeledMask == i) = 0;
        continue;
    end
    
    if width < 40 || height < 40
        labeledMask(labeledMask == i) = 0;
        continue;
    end
end

mask = logical(imfill(labeledMask, 'holes'));

end

