function channelMean = whitepoint(A)
%WHITEPOINT Summary of this function goes here
%   Detailed explanation goes here


B = sort(A, 'descend');


indices = B<100;
B(indices) = [];

sampleSizeR = floor(size(B)/20);

channelMean = mean(B(1:sampleSizeR));


end

