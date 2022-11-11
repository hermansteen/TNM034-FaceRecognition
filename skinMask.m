function mask = skinMask(image)
%% SKINMASK
%  Masks a facial image to get the mask corresponding to only the skin
%  Used for skin detection

% Get number of rows and columns in the image
[rows,cols] = size(image);

%% Get the the probability for a pixel value to appear and calculate the avergage

% Calculate the maximum intensity value(m) in the image
m = uint16(max(max(image)));

% Calculate the number of pixels in the image
N = rows * cols;

% Calculate the number of intensity occurences(n), probability(p) and
% average of the image
p = zeros(1,m+1);
average = 0.0;
for i = 0:m
    n = sum(image(:) == i);
    p(i+1) = n/N;
    average = average + i*p(i+1);
end


%% Calculate the best threshold for the mask
% T is the current threshold
omega = 0.0;
my = 0.0;
delta2 = [];

for T = 0:m
    for j = 1:T
        omega = omega + p(j+1);
        my = my + j*p(j+1);
    end

    omega0 = omega;
    my0 = my/omega;

    omega1 = 1.0 - omega;
    my1 = (average - my) / (1.0 - omega);

    graySampleAverage = omega0*my0 + omega1*my1;
    delta2(T+1) = (graySampleAverage*omega - my)^2 / (omega*(1.0 - omega));
end

bestThreshold = max(delta2);

%% Mask image depending on the threshold

mask = [];

end

