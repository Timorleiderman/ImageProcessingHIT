% Timor Leiderman Image Processing course 2020
clear

d = 10;
% ratinal_rgb = imread('ratinal.jpg');
ratinal_rgb = imread('ratinalRGB1.png');

ratinal_gray = rgb2gray(ratinal_rgb);
[h , w] = size(ratinal_gray);

G_fil = fspecial('gaussian',[50 50], 0.5);
ratina_gaus_fil = imfilter(double(ratinal_gray), G_fil, 'conv', 'circular');

low_pass = zeros(h,w);
low_pass(0.5*h-d:0.5*h+d,0.5*w-d:0.5*w+d) = 1;

ratinal_fft = fftshift(fft2(ratinal_gray));
ratinal_lpf_filtered = abs(ifft2(fftshift(ratinal_fft.*low_pass)));


superimpose = ratinal_lpf_filtered - ratina_gaus_fil + mean(ratina_gaus_fil);
% 
otsu_trash = graythresh(ratinal_gray);

otsu_gray = imbinarize(ratinal_gray, otsu_trash);
otsu_superimpose = imbinarize(uint8(superimpose), otsu_trash);


fig_h = 3;
fig_w = 3;
fig_idx = 1;

figure(1);

subplot(fig_h,fig_w,fig_idx);
imshow(uint8(ratinal_rgb));
txt = 'ratinal RGB orig';
title(txt);

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(ratinal_gray));
txt = 'ratinal gray orig';
title(txt);

fig_idx  = fig_idx + 2;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(ratinal_lpf_filtered));
txt = 'Low pass filter';
title(txt);

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(ratina_gaus_fil));
txt = 'gaussian filter';
title(txt);

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(superimpose));
txt = 'superimpose';
title(txt);

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(otsu_gray);
txt = 'Otsu on gray';
title(txt);

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(otsu_superimpose);
txt = 'superimpose + Otsu';
title(txt);


