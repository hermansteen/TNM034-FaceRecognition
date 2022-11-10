function colorCorrected = whitePoint(im)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
V = sort(im(:,:,1), 'descend');
V2 = sort(im(:,:,2),'descend');
V3 = sort(im(:,:,3), 'descend');
Top5R = V(1:ceil(end/5));
lambda = find(abs(Top5R)<100);
Top5R(lambda) = [];
Top5G = V2(1:ceil(end/5));
lambda = find(abs(Top5G)<100);
Top5G(lambda) = [];
Top5B = V3(1:ceil(end/5));
lambda = find(abs(Top5B)<100);
Top5B(lambda) = [];
RG = mean(Top5R)/mean(Top5G);
BG = mean(Top5B)/mean(Top5G);
colorCorrected(:,:,1) = im(:,:,1)*RG;
colorCorrected(:,:,2) = im(:,:,2);
colorCorrected(:,:,3) = im(:,:,3)*BG;
end

