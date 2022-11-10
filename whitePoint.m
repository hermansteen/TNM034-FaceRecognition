function whitepointImage = whitepoint(image)
%Calculates the whitepoint compensated image of an rgb image.


B = reshape(image(:,:,:), [],3);

Ar = chanelMean(B(:,1));
Ag = chanelMean(B(:,2));
Ab = chanelMean(B(:,3));

alpha = Ag/Ar;
beta = Ag/Ab;

image(:,:,1) = alpha * image(:,:,1);
image(:,:,3) = beta * image(:,:,3);

whitepointImage = image;

end

