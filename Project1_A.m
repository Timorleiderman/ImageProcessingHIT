% Timor Leiderman Project 1 image processing course 2020
clear

% find the path to the images
camera_man_path = which('cameraman.tif');
moon_path = which('moon.tif');

% load the images cameara man and moon
camera_man_img = imread(camera_man_path);
moon_img = imread(moon_path);

% resize the camera man image to the size of the moon so the size will fit
% and resize the moon image to the camera man image to fit
moon_size = size(moon_img);
camera_man_size = size(camera_man_img)

camera_man_img_resize = imresize(camera_man_img, [moon_size(1) moon_size(2)]);
moon_img_img_resize = imresize(moon_img, [camera_man_size(1) camera_man_size(2)]);

% fast fouirer transform
camera_man_img_fft = fft2(camera_man_img);
moon_img_fft = fft2(moon_img_img_resize);

% seperate amplituse and phase
camera_man_amp = abs( camera_man_img_fft );
moon_amp = abs( moon_img_fft );

camera_man_phase = angle( camera_man_img_fft );
moon_phase = angle( moon_img_fft );

% combine the amplitude and phase of the two images
ifft_camera_amp_moon_phase = camera_man_amp.*exp(j*moon_phase);
ifft_moon_amp_camera_phase = moon_amp.*exp(j*camera_man_phase);

img_out1 = uint8(ifft2(ifft_moon_amp_camera_phase));
img_out2 = uint8(ifft2(ifft_camera_amp_moon_phase));


figure(1)
subplot(2,2,1)
imshow(moon_img_img_resize);
title('moon image resized')
subplot(2,2,2)
imshow(camera_man_img);
title('camera man image orig')
subplot(2,2,3)
imshow(img_out1);
title('moon amplitude ;  camera man phase')
subplot(2,2,4)
imshow(img_out2);
title('camera man amplitude ; moon phase')
