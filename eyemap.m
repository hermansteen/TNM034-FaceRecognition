function maskedIm = eyemap(im, mask)
%EYEMASK Returns the eye mask of an image
%   Detailed explanation goes here
    YCbCr = double(rgb2ycbcr(im));
    gray = rgb2gray(im);
    %Illumination based approach
    Y = YCbCr(:,:,1);
    Cb = YCbCr(:,:,2);
    Cr = YCbCr(:,:,3);
    
    g = 1/3;
    
    ccb = Cb.^2;
    ccb = rescale(ccb, 0, 255);
    
    ccr = (255 - Cr).^2;
    ccr = rescale(ccr, 0, 255);
    
    cbcr = Cb./Cr;
    cbcr = rescale(cbcr, 0, 255);

    eyeMapC = g*(ccb + ccr + cbcr);
    eyeMapC = histeq(eyeMapC);

    SE = strel('disk', 6);
    o = imdilate(Y,SE);
    p = imerode(Y,SE);
    eyeMapL = o./p;
    
    eyeMap = eyeMapC.*eyeMapL;

    %Edge density based approach
    edgeDensitySE = strel('square', 8);
    edgeDensity = edge(gray, "sobel");
    edgeDensity = imdilate(edgeDensity, edgeDensitySE);
    edgeDensity = imdilate(edgeDensity, edgeDensitySE);
    edgeDensity = imerode(edgeDensity, edgeDensitySE);
    edgeDensity = imerode(edgeDensity, edgeDensitySE);
    edgeDensity = imerode(edgeDensity, edgeDensitySE);
    disp("This is edg")
    imshow(edgeDensity)
    
    eyeMap = eyeMap.*edgeDensity;
    maskedIm = imdilate(eyeMap,SE);
    maskedIm = maskedIm.*mask;
    maskedIm = rescale(maskedIm,0,255);
    maskedIm = uint8(maskedIm);
end

