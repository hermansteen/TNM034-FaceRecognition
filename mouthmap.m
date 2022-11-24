function output = mouthmap(im)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    YCbCr = rgb2ycbcr(im);
    YCbCr = im2double(YCbCr);
    Y = YCbCr(:,:,1);
    Cb = YCbCr(:,:,2);
    Cr = YCbCr(:,:,3);
    g = 1./3;
    Cb2 = Cb.^2;
    Crcomp = (1 - Cr).^2;
    CrCb = Cr./Cb;
    Cr2 = Cr.^2;
    
    eta = 0.95*(sum(sum(Cr2))/sum(sum(CrCb)));
    mouthMap = Cr2.*((Cr2-(eta.*CrCb)).^2);
    
    SE = strel('disk', 10);
    mouthMap = imclose(mouthMap,SE);
    output = mouthMap.*120;
    [rows,cols] = size(output);
    output((rows - 20):rows, :) = 0;
end