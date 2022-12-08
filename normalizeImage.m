function normImage = normalizeImage(img, eyes, mouth)
%NORMALIZE Summary of this function goes here
%   Detailed explanation goes here

if eyes.l.x > eyes.r.x
    
    leftY = eyes.r.y;
    rightY = eyes.l.y;

    leftX = eyes.r.x;
    rightX = eyes.l.x;
      
else
    
    leftY = eyes.l.y;
    rightY = eyes.r.y;

    leftX = eyes.l.x;
    rightX = eyes.r.x;

end

L = [leftX; leftY];
R = [rightX; rightY];
M = [mouth.x; mouth.y];

% Rotate image
deltaX = rightX-leftX;
hypotenuse = norm(L - R);
% 
% % Angle between the eyes
angle = acosd(deltaX/hypotenuse);

if leftY < rightY
    rotateIm = imrotate(img, angle,'bicubic'); 
    
else 
    angle = -angle;
    rotateIm = imrotate(img, angle,'bicubic'); 
end
    
rotMatrix = [cosd(angle) sind(angle); -sind(angle) cosd(angle)]; 
imCenterA = (size(img,1,2)/2)';         % Center of the main image
imCenterB = (size(rotateIm,1,2)/2)';  % Center of the transformed image
rotatedL = floor(rotMatrix*(L-imCenterA)+imCenterB);
rotatedR = floor(rotMatrix*(R-imCenterA)+imCenterB);
rotatedM = floor(rotMatrix*(M-imCenterA)+imCenterB);

[width, height] = size(rotateIm);

eyePos = floor(rotatedL + ((rotatedR - rotatedL)/2));


if(abs(eyePos(1)) < abs(width-eyePos(1)))
    padLeft = abs(floor((abs(eyePos(1)) - abs(width-eyePos(1)))));
    padRight = 0;

else
    padRight = ((abs(width-eyePos(1)) - abs(eyePos(1))));
    padLeft = 0;
end

if(abs(eyePos(2)) < abs((height-eyePos(2))))
    padUp = abs(floor(abs((height-eyePos(2)) - abs(eyePos(2)))));
    padDown = 0;
else
    padDown = abs(floor(abs(eyePos(2)) - abs(height-eyePos(2))));
    padUp = 0;
end

padded = padarray(rotateIm, [padUp, padLeft], 0, 'pre');
padded = padarray(padded, [padDown, padRight], 0, 'post');

imshow(padded);



xLeft = rotatedL(1) - 60;
xRight = rotatedR(1) + 60;
yTop = rotatedL(2) - 60;
yBottom = rotatedM(2) + 60;

croppedImage = rotateIm(yTop:yBottom, xLeft:xRight, :);
croppedImage = imresize(croppedImage, [250, 250]);

normImage = croppedImage;
end
