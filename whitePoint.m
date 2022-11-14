function whitepointImage = whitePoint(image)
%Calculates the whitepoint compensated image of an rgb image.


B = reshape(image(:,:,:), [],3);

Ar = channelMean(B(:,1));
Ag = channelMean(B(:,2));
Ab = channelMean(B(:,3));

alpha = Ag/Ar;
beta = Ag/Ab;

image(:,:,1) = alpha * image(:,:,1);
image(:,:,3) = beta * image(:,:,3);

whitepointImage = image;

end

