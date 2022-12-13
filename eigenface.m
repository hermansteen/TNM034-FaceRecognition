function result = eigenface(trainingSet,image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

threshold = 1.3 *  10^8;

[rows,cols,sz] = size(trainingSet); % (något smart, vet inte riktigt hur de ser ut)
M = zeros(rows*cols, 1);
imgvec = zeros(rows*cols, sz);
image = double(reshape(image, rows*cols, 1));

for i=1:sz
    
    %imgvec(:, i) = double(reshape(images(:,:,i), 1,[]));
    imgvec(:, i) = double(reshape(trainingSet(:,:,i), 1,[]));
    %All images are turned into vectors
    M = M + imgvec(:, i);
    
end

% Mean vector M of all the images
M = M./sz;

% Calculating A
imgvec = imgvec - M;

% 'Transpose' covariance matrix
C = imgvec' * imgvec;

% Eigenvectors to C
[V,D] = eig(C);

for i=1:sz
    u(:,i) = imgvec*V(:,i);
end

for i=1:sz
    for j=1:sz
        imageOhm(j,i) = u(:,j)'*imgvec(:,i);
    end
end

for i=1:sz
    imageOhmTest(i,1) = u(:,i)'*(image-M);
end

for i=1:sz
    dist(i) = norm(imageOhmTest - imageOhm(:,i));
end

index = find(dist == min(dist));

if dist(index) < threshold
    result = index;
else
    result = 0;
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


end

