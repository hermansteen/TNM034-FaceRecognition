function mask = skinMask(image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
level = graythresh(image);
mask = imbinarize(image, level);
labeledMask = bwlabel(mask, 8);

stats = regionprops(mask, 'EulerNumber', 'BoundingBox', 'Area');

for i = 1:size(stats)
    numberOfHoles = stats(i).EulerNumber;
    box = stats(i).BoundingBox;
    area = stats(i).Area;
    
    width = abs(box(3) - (1));
    height = abs(box(4) - box(2));
    whratio = height/width;
    areaRatio = area/(width*height);
    
    if numberOfHoles == 1
        labeledMask(labeledMask == i) = 0;
        continue;
    end
    
    if whratio > 2.0 || whratio < 0.8
        if whratio > 2.0
        
        else
            labeledMask(labeledMask == i) = 0;
        end
    end
    
    if areaRatio < 0
        labeledMask(labeledMask == i) = 0;
        continue;
    end
    
    if area < 2000
        labeledMask(labeledMask == i) = 0;
        continue;
    end
    
    if width < 40 || height < 40
        labeledMask(labeledMask == i) = 0;
        continue;
    end
end



SE1 = strel('disk', 2);
SE2 = strel('disk', 6);
mask = imopen(labeledMask, SE1);
mask = imclose(mask, SE2);
imshow(mask);
mask = logical(imfill(mask, 'holes'));

end

