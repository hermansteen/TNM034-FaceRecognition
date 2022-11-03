function maskedIm = eyemap(im)
%EYEMASK Returns the eye mask of an image
%   Detailed explanation goes here
    YCbCr = rgb2ycbcr(im);
    Y = YCbCr(:,:,1);
    Cb = YCbCr(:,:,2);
    Cr = YCbCr(:,:,3);
    g = 1./3;
    ccb = Cb.^2;
    ccr = (1 - Cr).^2;
    cbcr = Cb./Cr;

    eyeMapC = g*(ccb + ccr + cbcr);

    %Morphologically dilate and erode the image to create a mask
    SE = strel('disk', 10);
    o = imdilate(Y,SE);
    p = imerode(Y,SE);
    eyeMapL = o./p;
    eyeMap = eyeMapL.*eyeMapC;
    maskedIm = imdilate(eyeMap,SE);
end

