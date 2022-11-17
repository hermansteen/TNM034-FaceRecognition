function mask = skinMask(image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mask = imbinarize(image);
SE1 = strel('disk', 1);
SE2 = strel('disk', 12);
mask = imopen(mask, SE1);
mask = imclose(mask, SE2);
%mask = imopen(mask, SE2);
mask = imfill(mask, 'holes');


filled = imfill(mask, 'holes');
holes = filled & ~mask;
bigholes = bwareaopen(holes, 200);
smallholes = holes & ~bigholes;

mask = mask | smallholes;

imshow(mask);

mask = imopen(mask, SE2);


end

