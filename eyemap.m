function maskedIm = eyemap(im, mask)
%EYEMASK Returns the eye mask of an image
%   Detailed explanation goes here
    YCbCr = rgb2ycbcr(im);
    Y = double(YCbCr(:,:,1));
    Cb = double(YCbCr(:,:,2));
    Cr = double(YCbCr(:,:,3));
    g = 1/3;
    
    ccb = Cb.^2;
    ccb = rescale(ccb,0,255);
    
    ccr = (1 - Cr).^2;
    ccr = rescale(ccr,0,255);
    
    cbcr = Cb./Cr;
    cbcr = rescale(cbcr,0,255);

    eyeMapC = g*(ccb + ccr + cbcr);

    %Morphologically dilate and erode the image to create a mask
    SE = strel('disk', 6);
    o = imdilate(Y,SE);
    p = imerode(Y,SE);
    eyeMapL = o./p;
    eyeMap = eyeMapL.*eyeMapC;
    maskedIm = imdilate(eyeMap,SE);
    maskedIm = maskedIm.*mask;
    maskedIm = rescale(maskedIm,0,255);
    maskedIm = uint8(maskedIm);
end

