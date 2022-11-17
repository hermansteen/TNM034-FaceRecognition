function triangle = drawTriangle(eyes, mouth,image)
%DRAWTRIANGLE Summary of this function goes here
%   Detailed explanation goes here
imshow(image);
hold on
drawpolygon("Position",[[eyes.l.x eyes.l.y]; [eyes.r.x eyes.r.y]; [mouth.x mouth.y]]);
hold off
triangle = drawpolygon("Position",[[eyes.l.x eyes.l.y]; [eyes.r.x eyes.r.y]; [mouth.x mouth.y]]);
end

