function mask = skinMask(image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mask = imbinarize(image);
labeledMask = bwlabel(mask, 8);

stats = regionprops(mask, 'EulerNumber', 'BoundingBox', 'Area');

for i = 1:size(stats)
    numberOfHoles = stats(i).EulerNumber;
    box = stats(i).BoundingBox;
    area = stats(i).Area;
    
    width = abs(box(3) - (1));
    height = abs(box(4) - box(2));
    whratio = width/height;
    hwratio = height/width;
    areaRatio = area/(width*height);
    
    if numberOfHoles == 1
        labeledMask(labeledMask == i) = 0;
        continue;
    end
    
    if hwratio < 0.8
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
    
    if width < 20 || height < 20
        labeledMask(labeledMask == i) = 0;
        continue;
    end
end

mask = logical(imfill(labeledMask, 'holes'));

end

