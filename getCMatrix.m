function C = getCMatrix(images, m)
%GETCMATRIX Summary of this function goes here
%   Detailed explanation goes here
    C = [0,0; 0,0]; 
    %index = size(images);
    %index = index(2);
% for i=1:index
%     image = cell2mat(images(1,i));
%     image = rgb2ycbcr(image);
%     Cb = double(image(:,:,2))-m(1);
%     Cr = double(image(:,:,3))-m(2);
%     C(1,1) = C(1,1) + mean(Cb.*Cb, 'all');
%     C(1,2) = C(1,2) + mean(Cb.*Cr, 'all');
%     C(2,1) = C(2,1) + mean(Cb.*Cr, 'all');
%     C(2,2) = C(2,2) + mean(Cr.*Cr, 'all');
%     C = C + cov(Cb, Cr);
% end


   %C = (C ./ index);
images = rgb2ycbcr(images);
Cb = double(images(:,:,2))-m(1);
Cr = double(images(:,:,3))-m(2);

C = cov(Cb, Cr);


end

