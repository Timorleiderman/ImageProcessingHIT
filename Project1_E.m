% Timor Leiderman Project 1 image processing 2020
% Based on the paper Review of motion Blur Estimation Techniques
clear
% Motion Blur parameters estimation
% define parameters for angle and length
L1 = 20;
L2 = 40;
alpha = 30;
theta = 0:5:180;
wavelength = 10;

rect_L = 10;

% find the path to the images
camera_man_path = which('cameraman.tif');
% load the image
camera_man_img = double(imread(camera_man_path));

% get the size of the image
[m, n] = size(camera_man_img);

% generate filters
h1 = fspecial('motion', L1, alpha);

% apply filters
motion_blur_camera_man1 = imfilter(camera_man_img, h1, 'conv', 'circular');

% FFT and remove edges for adge artifacts
camera_man_img_fft = fft2(camera_man_img);
motion_blur_camera_man_fft1 = fft2(motion_blur_camera_man1);

% calc log spectrum
log_spec_camera_man_fft = log(abs(camera_man_img_fft));
log_spec_camera_man_fft1 = log(abs(motion_blur_camera_man_fft1));

cepstrum_func = ifft2(log_spec_camera_man_fft);
cepstrum_func1 = ifft2(log_spec_camera_man_fft1);

% plot the resaults
fig_h = 2;
fig_w = 2;
fig_idx = 1;

figure(1);

subplot(fig_h,fig_w,fig_idx);
imshow(uint8(camera_man_img));
title('Camera man image');
fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(motion_blur_camera_man1));
txt=['motion blur L=20 theta=30'];
title(txt);

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(fftshift(cepstrum_func));
txt=['cepstrum orig'];
title(txt);
axis('off');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(fftshift(cepstrum_func1));
txt=['cepstrum blur'];
title(txt);
axis('off');
