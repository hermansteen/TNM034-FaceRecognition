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

[height, width, channels] = size(rotateIm);

eyeCenter = floor(rotatedL + ((rotatedR - rotatedL)/2));

paddedL = rotatedL;
paddedR = rotatedR;
paddedM = rotatedM;

if eyeCenter(1) < abs(width-eyeCenter(1))
    padLeft = floor(abs( eyeCenter(1) - abs(width-eyeCenter(1)) ));
    padRight = 0;

    % New x-positions for eyes, mouth, and center
    paddedL(1) = paddedL(1) + padLeft;
    paddedR(1) = paddedR(1) + padLeft;
    paddedM(1) = paddedM(1) + padLeft;
    eyeCenter(1) = eyeCenter(1) + padLeft;
else
    padRight = floor(abs( abs(width-eyeCenter(1)) - eyeCenter(1) ));
    padLeft = 0;
end

if eyeCenter(2) < abs(height-eyeCenter(2))
    padUp = floor(abs( eyeCenter(2) - abs(height-eyeCenter(2)) ));
    padDown = 0;

    % New y-positions for eyes, mouth, and center
    paddedL(2) = paddedL(2) + padUp;
    paddedR(2) = paddedR(2) + padUp;
    paddedM(2) = paddedM(2) + padUp;
    eyeCenter(2) = eyeCenter(2) + padUp;
else
    padDown = floor(abs( abs(height-eyeCenter(2)) - eyeCenter(2)));
    padUp = 0;
end

padded = padarray(rotateIm, [padUp, padLeft], 0, 'pre');
padded = padarray(padded, [padDown, padRight], 0, 'post');

xLeft = floor(eyeCenter(1) - 150);
xRight = floor(eyeCenter(1) + 150);
yTop = floor(eyeCenter(2) - 150);
yBottom = floor(eyeCenter(2) + 200);

croppedImage = padded(yTop:yBottom, xLeft:xRight, :);

normImage = croppedImage;
end
