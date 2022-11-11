function C = getCMatrix(images)
%GETCMATRIX Summary of this function goes here
%   Detailed explanation goes here
    C = [0,0]; 
    index = size(images);
    index = index(2);
for i=1:index
    image = cell2mat(images(1,i));
    image = rgb2ycbcr(image);
    Cb = image(:,:,2);
    Cr = image(:,:,3);
    C = C + cov(double(Cb), double(Cr));
end
   C = C ./ index;
end

