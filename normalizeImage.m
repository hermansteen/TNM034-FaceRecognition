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

% Rotate image
deltaX = rightX-leftX;
hypotenuse = norm([leftX leftY] - [rightX rightY]);
% 
% % Angle between the eyes
angle = rad2deg(acos(deltaX/hypotenuse));


if leftY < rightY
    rotateIm = imrotate(img, angle,'bicubic'); 
else
    rotateIm = imrotate(img, -angle,'bicubic'); 
end
    

    

normImage = rotateIm;
end

