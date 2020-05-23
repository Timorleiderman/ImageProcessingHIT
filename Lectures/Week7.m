% Timor Leiderman 11_05_2020
% matlab week 7
% talked about qunatization, uniform, loyd-max etc..
%1/deltax = omega_s_x <= 2omega_x_0; omega 2*pi*f

A = imread('cameraman.tif');

salt_pep_noise = imnoise(A,'salt & pepper',0.02);
gauss_noise = imnoise(A,'gaussian');

h = ones(3,3)./9;

filtered = imfilter(salt_pep_noise,h);

fig_h = 2;
fig_w = 3;
fig_idx = 1;

figure(1);
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(A));
title('Orig image');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(salt_pep_noise));
title('salt_pep_noise');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(gauss_noise));
title('gauss_noise');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(filtered));
title('filtered');


