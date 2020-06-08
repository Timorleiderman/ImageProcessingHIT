% Timor Leiderman Project 1 image processing 2020
clear

I = zeros(313);
theta = 0:180;
[m,n] = size(I);

for i = 1:m
    for j = 1:n
        I(j,40) = 255;
        I(j,80) = 255;
        I(j,124) = 255;
        I(j,150) = 255;
    end
end

[R, xp] = radon(I,theta);

I1 = zeros(313);
I1(40,40) = 255;
I1(80,80) = 255;
I1(124,124) = 255;
I1(150,150) = 255;

[R1, xp1] = radon(I1,theta);
figure(1)
subplot(2,1,1)
imagesc(theta,xp,R);
title('Radon of 4 Lines')
axis('off')
subplot(2,1,2)
imagesc(theta,xp1,R1);
title('Radon 4 Dots')
axis('off')

figure(2)
subplot(2,2,1)
imshow(I);
title('4 Lines')
subplot(2,2,2)
imshow(R);
title('Radon of 4 Lines')

subplot(2,2,3)
imshow(I1);
title('4 Dots')
subplot(2,2,4)
imshow(R1);
title('Radon 4 Dots')

