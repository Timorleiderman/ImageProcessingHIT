% Timor Leiderman Image Processing course 2020
% Based on Fast image dehazing using guided joint bilateral filter

clear

%deefine variables
sigma = 1.2;
window_size = 3;
% load the image
img_in = double(imread('Fig1.png'));

I = log(1 + img_in);
% get the size of the image
[h, w, ch] = size(img_in);

M = 2*h + 1;
N = 2*w + 1;

[X, Y] = meshgrid(1:N,1:M);
centerX = ceil(N/2);
centerY = ceil(M/2);
gaussianNumerator = (X - centerX).^2 + (Y - centerY).^2;
H = exp(-gaussianNumerator./(2*sigma.^2));
H = 1 - H;

% wind = floor(window_size/2);
% [X,Y] = meshgrid(-wind:wind,-wind:wind);
% gs = 1 - exp(-(X.^2+Y.^2)/(2*sigma^2));
% H = 1 - gs;

H = fftshift(H);
If = fft2(I, M, N);
Iout = real(ifft2(H.*If));
Iout = Iout(1:size(I,1),1:size(I,2));

Ihmf = exp(Iout) - 1;

% plot the resaults
fig_h = 3;
fig_w = 3;
fig_idx = 1;

figure(1);
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(img_in));
title('Orig image');

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(Ihmf),[]);
title('Ihmf');



