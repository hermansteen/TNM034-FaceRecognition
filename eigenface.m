function result = eigenface(trainingSet,image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

threshold = 0.3;

for i=1:16
    
    images(:,:,i) = zeros(300);

end

sz = size(images, 3);
%sz = size(trainingSet(:,:,i) (något smart, vet inte riktigt hur de ser ut)
M = zeros(300*300, 1);

for i=1:sz
    
    imgvec(:, i) = double(reshape(images(:,:,i), 1,[]));
    %imgvec(:, i) = double(reshape(trainingSet(:,:,i), 1,[]));
    %All images are turned into vectors
    M = M + imgvec(:, i);
    
end



M = M./sz;
%Mean vector M of all the images
imgvec(:, :) = imgvec(:, :) - M;
%Calculating A

%image(:,1) = double(reshape(image(:,:), 1,[]));
%image = image - M;

C = imgvec(:,:)' * imgvec(:,:);
%'Transpose' covariance matrix
V = eig(C);
%eigenvectors to C

e = 0;
for i=1:sz
    u(:,i) = imgvec(:,i).*V(i,1);
    %imageOhm(:,i) = u(:,i)*image(:,:);
    for j=1:sz
        weights(j,i) =u(:,i)'*imgvec(:,j);
        %e = e + abs((weights(j,i) - u(:,i)));
    end
    %imageOhm(:,i) = e;
    %e = 0;

end

index = find(imageOhm == min(imageOhm));
if imageOhm(index) == 0
    result = 0;

end

if imgaeOhm(index) < threshold
    result = 1;
else result = 0; 
end



%Check the smallest distance to each images' weights vector.
%If the smallest distance is below a given threshold the image is in the 
%training set(dataset)









%All images are the same size.
%Every image loaded in and turned into a vector
%Medelvektor M råknas ut 
%Subtrahera M från varje bild -> Phi
%Hitta cov för alla de här nya bilderna A = [Phi1, Phi2...]
%C=A*A^T. Vi vill istället ha A^T*A
%Hitta egenvektorerna vi från den här nya matrisen
%u = A*vi
%reshape till matriser så får man bilderna
%Varje ansikte kan nu beskrivas som I = M + sum(j=1, K, wjuj)
%wj är vikten för det eigenface, kan räknas ut som wj = uj^T * Phii
%Phii är Bilden i - M, spara alla w i en vektor ohm

























outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

