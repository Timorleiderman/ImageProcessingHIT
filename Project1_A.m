% Timor Leiderman Project 1 image processing 2020
clear

% find the path to the images
camera_man_path = which('cameraman.tif');
moon_path = which('moon.tif');

% load the images cameara man and moon
camera_man_img = imread(camera_man_path);
moon_img = imread(moon_path);

% resize the camera man image to the size of the moon so the size will fit
moon_size = size(moon_img);
camera_man_img = imresize(camera_man_img, [moon_size(1) moon_size(2)]);

% fast fouirer transform
camera_man_img_fft = fft2(camera_man_img);
moon_img_fft = fft2(moon_img);

% seperate amplituse and phase
camera_man_amp = real( camera_man_img_fft );
moon_amp = real( moon_img_fft );

camera_man_phase = angle( camera_man_img_fft );
moon_phase = angle( moon_img_fft );

% combine the amplitude and phase of the two images
ifft_camera_amp_moon_phase = camera_man_amp.*exp(j*moon_phase);
ifft_moon_amp_camera_phase = moon_amp.*exp(j*camera_man_phase);

img_out1 = ifft(ifft_moon_amp_camera_phase);
img_out2 = ifft(ifft_camera_amp_moon_phase);


figure(1)
subplot(2,2,1)
imshow(moon_img);
subplot(2,2,2)
imshow(camera_man_img);
subplot(2,2,3)
imshow(img_out1);
subplot(2,2,4)
imshow(img_out2);
