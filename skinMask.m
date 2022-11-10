function mask = skinMask(image)
%% SKINMASK
%  Masks a facial image to get the mask corresponding to only the skin
%  Used for skin detection

%% Convert image from RGB to YCrCb

YCbCr = rgb2ycbcr(image);

% Separate Y, Cb, and Cr
Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

% Get number of rows and columns in the image
[rows,cols] = size(Y);

%% Get the the probability for a pixel value to appear and calculate the avergage

% Calculate the maximum intensity value(m) in the image
m = max(max(Y));

% Calculate the number of pixels in the image
N = rows * cols;

% Calculate the number of intensity occurences(n), probability(p) and
% average of the image
p = [];
n = [];
average = 0.0;

for i = 1:m
    n(i) = sum(Y(:) == i);
    p(i) = n(i)/N;
    average = average + i*p(i);
end

%% Calculate the best threshold for the mask
% T is the current
omega = 0.0;
my = 0.0;
delta2 = [];

for T = 1:m
    for i = 1:T
        omega = omega + p(i);
        my = my + i*p(i);
    end

    omega0 = omega;
    my0 = my/omega;

    omega1 = 1.0 - omega;
    my1 = (average - my) / (1.0 - omega);

    graySampleAverage = omega0*my0 + omega1*my1;
    delta2(T) = (graySampleAverage*omega - my)^2 / (omega*(1.0 - omega));
end

bestThreshold = max(delta2);

%% Mask image depending on the threshold

mask = [];

end

