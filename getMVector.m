function m = getMVector(images)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    index = size(images);
    index = index(2);
    CBmean = 0;
    CRmean = 0;
for i=1:index
    image = cell2mat(images(1,i));
    image = rgb2ycbcr(image);
    Cb = image(:,:,2);
    Cr = image(:,:,3);
    CBmean = CBmean + mean(Cb, 'all');
    CRmean = CRmean + mean(Cr, 'all');
end

CBmean = CBmean ./ index;
CRmean = CRmean ./ index;
m = [CBmean, CRmean];

end

