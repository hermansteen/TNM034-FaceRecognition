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
    
RotMatrix = [cosd(angle) sind(angle); -sind(angle) cosd(angle)]; 
ImCenterA = (size(img,1,2)/2)';         % Center of the main image
ImCenterB = (size(rotateIm,1,2)/2)';  % Center of the transformed image
RotatedL = floor(RotMatrix*(L-ImCenterA)+ImCenterB);
RotatedR = floor(RotMatrix*(R-ImCenterA)+ImCenterB);
RotatedM = floor(RotMatrix*(M-ImCenterA)+ImCenterB);

[rows, cols] = size(rotateIm);

xLeft = RotatedL(1) - 60;
xRight = RotatedR(1) + 60;
yTop = RotatedL(2) - 60;
yBottom = RotatedM(2) + 60;

croppedImage = rotateIm(yTop:yBottom, xLeft:xRight, :);
croppedImage = imresize(croppedImage, [250, 250]);

normImage = croppedImage;
end
