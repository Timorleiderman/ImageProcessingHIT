% Timor Leiderman Project 1 image processing 2020
clear

% find the path to the images
camera_man_path = which('cameraman.tif');
camera_man_img = imread(camera_man_path);

L1 = 20;
L2 = 40;
alpha = 30;

[m,n] = size(camera_man_img);

h1 = fspecial('motion', L1, alpha);
h2 = fspecial('motion', L2, alpha);

motion_blur_camera_man1 = imfilter(camera_man_img,h1,'replicate');
motion_blur_camera_man2 = imfilter(camera_man_img,h2,'replicate');

camera_man_img_fft = fftshift(fft2(camera_man_img));
motion_blur_camera_man_fft1 = fftshift(fft2(motion_blur_camera_man1));
motion_blur_camera_man_fft2 = fftshift(fft2(motion_blur_camera_man2));

figure(1)
subplot(2,3,1)
imshow(camera_man_img);
title('Camera man image')
subplot(2,3,2)
imshow(motion_blur_camera_man1);
title('motion blur L=20 theta=30')
subplot(2,3,3)
imshow(motion_blur_camera_man2);
title('motion blur L=40 theta=30')
subplot(2,3,4)
imshow(camera_man_img_fft);
title('fft of camera man')
subplot(2,3,5)
imshow(motion_blur_camera_man_fft1);
title('fft of motion blur L=20')
subplot(2,3,6)
imshow(motion_blur_camera_man_fft2);
title('fft of motion blur L=40')
