function normImage = normalizeImage(img, eyes, mouth)
%NORMALIZE Summary of this function goes here
%   Detailed explanation goes here
% Rescale image
[height, width, channels] = size(img);

if eyes.l.x == 0 || eyes.l.y == 0 || eyes.r.x == 0 || eyes.r.y == 0
    normImage = zeros(351,301,channels);
else

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

    eyeCenter = floor(L + ((R - L)/2));

    paddedL = L;
    paddedR = R;
    paddedM = M;

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

    padded = padarray(img, [padUp, padLeft], 0, 'pre');
    padded = padarray(padded, [padDown, padRight], 0, 'post');

% 
%     imshow(padded);
%     hold on
%         plot(paddedL(1), paddedL(2), 'ro', 'MarkerSize', 10);
%         plot(paddedR(1), paddedR(2), 'go', 'MarkerSize', 10);
%         plot(paddedM(1), paddedM(2), 'bo', 'MarkerSize', 10);
%     hold off+

    % Rotate image
    deltaX = paddedR(1)-paddedL(1);
    hypotenuse = norm(paddedL - paddedR);
    
    % % Angle between the eyes
    angle = acosd(deltaX/hypotenuse);

    if paddedL(2) < paddedR(2)
        rotateIm = imrotate(padded, angle,'bicubic'); 

    else 
        angle = -angle;
        rotateIm = imrotate(padded, angle,'bicubic'); 
    end

    rotMatrix = [cosd(angle) sind(angle); -sind(angle) cosd(angle)]; 
    imCenterA = (size(padded,1,2)/2)';         % Center of the main image
    imCenterB = (size(rotateIm,1,2)/2)';  % Center of the transformed image
    rotatedL = floor(rotMatrix*(paddedL-imCenterA)+imCenterB);
    rotatedR = floor(rotMatrix*(paddedR-imCenterA)+imCenterB);
    rotatedM = floor(rotMatrix*(paddedM-imCenterA)+imCenterB);
    eyeCenter = floor(rotatedL + ((rotatedR - rotatedL)/2));

    

    % Scale image to 750 x 750
%     rotateIm = imresize(rotateIm, [750 750]);
%     xle = rotatedL(1)/double(width);
%     yle = rotatedL(2)/double(height);
%     xre = rotatedR(1)/double(width);
%     yre = rotatedR(2)/double(height);
%     xm = rotatedM(1)/double(width);
%     ym = rotatedM(2)/double(height);
% 
%     [height, width, channels] = size(rotateIm);
%    
%     rotatedL = [width*xle, height*yle];
%     rotatedR = [width*xre, height*yre];
%     rotatedM = [width*xm, height*ym];


    xLeft = floor(imCenterB(2) - 150);
    xRight = floor(imCenterB(2) + 150);
    yTop = floor(imCenterB(1) - 100);
    yBottom = floor(imCenterB(1) + 200);

    croppedImage = padded(yTop:yBottom, xLeft:xRight, :);
    

    normImage = croppedImage;
end
end
