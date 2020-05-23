% Timor Leiderman Image Processing course 2020
% Based on Fast image dehazing using guided joint bilateral filter

clear

%deefine variables

window_size = 3;

% load the image
img_in = imread('Fig1.png');

% get the size of the image
[h, w, ch] = size(img_in);

img_in_double = double(img_in);

sigma = std2(img_in_double)/h;

img_in_log = log(1 + img_in_double);

img_in_fft = fftshift(fft2(img_in_log));

% create gaussian filter
[X, Y] = meshgrid(1:w,1:h);
centerX = ceil(w/2);
centerY = ceil(h/2);
gaussianNumerator = (X-centerX).^2 + (Y-centerY).^2;
H = 1 - exp(-gaussianNumerator./(2*sigma.^2));

% apply gaussian filter
H_filtered = img_in_fft.*H;

H_fil_ifft = ifft2(ifftshift(H_filtered));

G = abs(exp(H_fil_ifft) + 1);

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
imshow(uint8(abs(img_in_fft)));
title('img in fft');
axis('off');

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(abs(H_filtered)), []);
title('img filtered');

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(G));
title('G');








