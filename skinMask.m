function mask = skinMask(image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[rows,cols] = size(image);
level = graythresh(image);

mask = imbinarize(image, level);

SE = strel('disk', 5);
SE1 = strel('disk', 4);
mask = imdilate(mask, SE1);
mask = imclose(mask,SE);

labeledMask = bwlabel(mask, 8);

imshow(labeledMask);

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
    
    if area < 400
        labeledMask(labeledMask == i) = 0;
        continue;
    end
    
    if width < 40 || height < 40
        labeledMask(labeledMask == i) = 0;
        continue;
    end
end


labeledMask(:, 1:80) = 0;
labeledMask(1:80, :) = 0;
temp = (cols - 70);
temp2 = (rows - 20);
labeledMask(:, temp:cols) = 0;
labeledMask(floor(3*rows/5):rows, :) = 0;

mask = logical(imfill(labeledMask, 'holes'));

end

