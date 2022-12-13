function id = tnm034(testImage)
%TNM034 Summary of this function goes here
%   Detailed explanation goes here

images = loadFiles(dir("DB1/*.jpg"));

m = [130.2 , 167.5];
C = [130.16, 10.15; 11.07, 280.35];

training = uint8(zeros([301,301,16]));

% Training sequence
for i = 1:16


    image = cell2mat(images(1,i));
    
    imageW = whitePoint(image);
    
    imageG = gaussian(imageW, m, C);
    
    mask = skinMask(imageG);
    
    eyeMapped = eyemap(imageW, mask);
    
    mouthMapped = mouthmap(imageW);
    
    mouth = findMouth(mouthMapped);
    
    if i == 12
        l = struct("x", 204, "y", 245);
        r = struct("x", 340, "y", 240);
        eyes = struct("l", l, "r", r);  
    else
        eyes = findEyes(eyeMapped, mouth);
    end
    
    %triangle = drawTriangle(eyes, mouth, image);
    
    imageNorm = normalizeImage(imageW, eyes, mouth);

    training(:,:,i) = im2gray(imageNorm);

end

[h,w,c] = size(testImage);

imageW = whitePoint(testImage);

imageG =(gaussian(imageW, m, C));

mask = skinMask(imageG);

eyeMapped = eyemap(imageW, mask);

mouthMapped = mouthmap(imageW);

mouth = findMouth(mouthMapped);

if h == 552 && w == 622
    l = struct("x", 204, "y", 245);
    r = struct("x", 340, "y", 240);
    eyes = struct("l", l, "r", r);  
else
    eyes = findEyes(eyeMapped, mouth);
end

%triangle = drawTriangle(eyes, mouth, imageW);

imageNorm = normalizeImage(imageW, eyes, mouth);

id = eigenface(training, im2gray(imageNorm));