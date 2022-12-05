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

    SE = strel('disk', 7);
    o = imdilate(Y,SE);
    p = imerode(Y,SE);
    eyeMapL = o./p;
    
    eyeMap = eyeMapC.*eyeMapL;

    %Edge density based approach
    edgeDensitySE = strel('disk', 4);
    edgeDensity = edge(gray, "sobel");
    edgeDensity = imdilate(edgeDensity, edgeDensitySE);
    edgeDensity = imdilate(edgeDensity, edgeDensitySE);
    edgeDensity = imerode(edgeDensity, edgeDensitySE);
    edgeDensity = imerode(edgeDensity, edgeDensitySE);
    edgeDensity = imerode(edgeDensity, edgeDensitySE);
    %disp("This is edg")
    %imshow(edgeDensity)
    edgeDensity = bwpropfilt(edgeDensity, 'Solidity', [0.5 inf]);
    edgeDensity = imclearborder(edgeDensity, 26);

    %colour based method
    imHist = histeq(rgb2gray(im));
    imHist = imHist > 40;
    imHist = imdilate(imHist, strel('disk', 6));
    imshow(imHist)
    imHist = bwpropfilt(imHist, 'Solidity', [0.5 inf]);
    imHist = imclearborder(imHist);
    imHist = bwpropfilt(imHist, 'Orientation', [-45 45]);
    stats = regionprops(imHist, 'MinorAxisLength', 'MajorAxisLength', 'BoundingBox');
    stats = struct2table(stats);
    stats.AspectRatio = stats.MajorAxisLength / stats.MinorAxisLength;
    toDelete = stats.AspectRatio < 0.8 & stats.AspectRatio > 4.5;
    stats(toDelete, :) = [];
    for i=1:height(stats)
        bbox = stats(i,:).BoundingBox;
        x1 = ceil(bbox(1));
        x2 = round(x1+bbox(3));
        y1 = ceil(bbox(2));
        y2 = round(y1+bbox(4));
        imHist(y1:y2, x1:x2) = 0;
    end

    %combine all three
    eyeMap = eyeMap.*edgeDensity;
    eyeMap = eyeMap .* imHist;
    %disp("This is eyemap")
    %imshow(eyeMap)
    maskedIm = imdilate(eyeMap,SE);
    maskedIm = maskedIm.*mask;
    maskedIm = rescale(maskedIm,0,255);
    maskedIm = uint8(maskedIm);
end

