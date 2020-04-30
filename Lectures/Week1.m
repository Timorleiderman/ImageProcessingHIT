% Timor Leiderman 16_03_2020
% matlab week 1 intoduction
% List of built in demo images
% https://www.mathworks.com/matlabcentral/answers/54439-list-of-builtin-demo-images
clear all
clear

camera_man_path = which('cameraman.tif');
peppers_path = which('peppers.png');

camera_man_img = imread(camera_man_path);
peppers_img = imread(peppers_path);

figure(1)
subplot(2,2,1)
imshow(peppers_img)
title('demo image pappers')

% split the image to channels
R_pepers = peppers_img(:,:,1);
G_pepers = peppers_img(:,:,2);
B_pepers = peppers_img(:,:,3);

subplot(2,2,2)
imshow(R_pepers)
title('R channel')
% display camera man
figure(2)
subplot(2,2,1)
imshow(camera_man_img)
title('camera man demo image')
% Display image with scaled colors
subplot(2,2,2)
imagesc(camera_man_img) 
title('camera man scaled colors')

% using rgb2grey function
figure(1)
gray_peppers = rgb2gray(peppers_img);
subplot(2,2,3)
imshow(gray_peppers)
title('peppers rgb 2 grayscale')

% talk about pixel neighbors
% talk about distance (Metric) 
% PSF - point spread function
% image = PSF * object function + noise
% LSI (Linear shift Invarient) system
% space invarient, shift invariant
% Impulse response
% FIR finite impulse response
% IIR infinite impulse responce
% talk about 2d discrete convolution
% block matrix kronecker
% Toeplitz (circulant) matrix

% example for convolution

x = [4 5 6; 7 8 9];
h = [1; 1; 1];
% conv function 'full' 'same' 'valid'
conv_xh = conv2(x,h);

%example on camera man image
conv_xh_same = conv2(x,h, 'same');
conv_xh_full = conv2(x,h, 'full');
conv_xh_valid = conv2(x,h, 'valid');

h_filter_1_9 = ones(3,3)./9;
camera_man_img_blur_same = uint8(conv2(camera_man_img,h_filter_1_9, 'same'));
camera_man_img_blur_full = uint8(conv2(camera_man_img,h_filter_1_9, 'full'));

figure(2)
subplot(2,2,3)
imshow(camera_man_img_blur_same) 
title('camera man blured same')
subplot(2,2,4)
imshow(camera_man_img_blur_full) 
title('camera man blured full')

