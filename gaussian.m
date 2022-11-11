function image = gaussian(arg, m, C)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

image= rgb2ycbcr(arg);
height = size(image,1);
width = size(image, 2);


CB = double(reshape(image(:,:,2), 1,[]));
CR = double(reshape(image(:,:,3), 1,[]));

im = CB;
index = size((im));
index = index(2);


for i = 1:index
    R = [CB(1, i)-m(1), CR(1, i)-m(2)];
    prob = -0.5*((R*(C^-1)*R'));
    im(1,i) = (exp(prob));

end
image = reshape(im(1,:), height,width);

image = uint8(rescale(image,0,255));


end

