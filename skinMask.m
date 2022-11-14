function mask = skinMask(image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mask = imbinarize(image);
SE1 = strel('disk', 16);
SE2 = strel('disk', 4);
mask = imclose(mask, SE1);
mask = imopen(mask, SE2);
mask = imfill(mask, 'holes');


end

