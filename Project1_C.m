% Timor Leiderman Project 1 image processing 2020
clear

% find the path to the images
camera_man_path = which('cameraman.tif');
camera_man_img = double(imread(camera_man_path));

% define parameters for angle and length
L1 = 20;
L2 = 40;
alpha = 30;
theta = 0:180;

[m,n] = size(camera_man_img);

% generate filters
h1 = fspecial('motion', L1, alpha);
h2 = fspecial('motion', L2, alpha);

% apply filters
motion_blur_camera_man1 = imfilter(camera_man_img,h1,'conv','circular');
motion_blur_camera_man2 = imfilter(camera_man_img,h2,'conv','circular');

% FFT
camera_man_img_fft = fftshift(fft2(camera_man_img));
motion_blur_camera_man_fft1 = fftshift(fft2(motion_blur_camera_man1));
motion_blur_camera_man_fft2 = fftshift(fft2(motion_blur_camera_man2));

% calc log spectrum
log_spec_camera_man_fft = abs(log2(camera_man_img_fft));
log_spec_camera_man_fft1 = abs(log2(motion_blur_camera_man_fft1));
log_spec_camera_man_fft2 = abs(log2(motion_blur_camera_man_fft2));

% Radon transform
[R1, xp1] = radon(log_spec_camera_man_fft1, theta);
[R2, xp2] = radon(log_spec_camera_man_fft2, theta);

% find the peak
maxR1 = max(R1(:));
maxR2 = max(R2(:));

[row_idx1, col_idx1] = find(R1 == maxR1);
[row_idx2, col_idx2] = find(R2 == maxR2);

% find corresponding angle
angle_blur_camera_man1 = theta(col_idx1);
angle_blur_camera_man2 = theta(col_idx2);

% apply wiener filter
wnr_blur_camera_man_1 = deconvwnr(motion_blur_camera_man1,h1);
wnr_blur_camera_man_2 = deconvwnr(motion_blur_camera_man2,h2);

% plot the resaults
fig_h = 4;
fig_w = 3;
fig_idx = 1;

figure(1)
subplot(fig_h,fig_w,fig_idx)
imshow(uint8(camera_man_img));
title('Camera man image')
fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx)
imshow(uint8(motion_blur_camera_man1));
title('motion blur L=20 theta=30')
fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx)
imshow(uint8(motion_blur_camera_man2));
title('motion blur L=40 theta=30')
fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx)
imshow(uint8(camera_man_img_fft));
title('fft of camera man')
fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx)
imshow(uint8(motion_blur_camera_man_fft1));
title('fft of motion blur L=20')
fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx)
imshow(uint8(motion_blur_camera_man_fft2));
title('fft of motion blur L=40')
fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx)
imagesc(log_spec_camera_man_fft);
title('camera man orig')
axis('off')
fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx)
imagesc(log_spec_camera_man_fft1);
title('camera man blur L=20')
axis('off')
fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx)
imagesc(log_spec_camera_man_fft2);
title('camera man blur L=40')
axis('off')
fig_idx  = fig_idx + 2;
subplot(fig_h,fig_w,fig_idx)
imshow(uint8(wnr_blur_camera_man_1));
title('camera man weiner filterr L=20')
fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx)
imshow(uint8(wnr_blur_camera_man_2));
title('camera man weiner filterr L=40')
