% Timor Leiderman Project 1 image processing 2020
clear

I = zeros(313);
[m,n] = size(I);

for i = 1:m
    for j = 1:n
        I(j,40) = 255;
        I(j,80) = 255;
        I(j,124) = 255;
        I(j,150) = 255;
    end
end

R = radon(I);
I1 = zeros(313);
I1(40,40) = 255;
I1(80,80) = 255;
I1(124,124) = 255;
I1(150,150) = 255;

R1 = radon(I1);


figure(1)
subplot(2,2,1)
imshow(I);
subplot(2,2,2)
imshow(R);

subplot(2,2,3)
imshow(I1);
subplot(2,2,4)
imshow(R1);

