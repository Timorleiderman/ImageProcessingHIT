% Timor Leiderman Project 1 image processing 2020
% Based on the paper Motion blur parameters estimation for image restoration
function Project1_D
% define parameters for angle and length
L1 = 20;
L2 = 40;
alpha = 30;
theta = 0:5:180;
wavelength = 10;
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
camera_man_img_fft = fftshift(fft2(camera_man_img));
motion_blur_camera_man_fft1 = fftshift(fft2(motion_blur_camera_man1));

% calc log spectrum
log_spec_camera_man_fft = abs(log(camera_man_img_fft));
log_spec_camera_man_fft1 = abs(log(motion_blur_camera_man_fft1));

% gabor angles vector initialize
gabor_angles = zeros(length(theta),1);
for i = 1: length(theta)
    % define gabor function
    g = gabor(wavelength,theta(i));
    
    % convolv gabor kernel with the log fft of the blured image
    conv_gabor_log_fft1 = conv2(log_spec_camera_man_fft1, g(:).SpatialKernel, 'same');
    
    % find the maxima
    gabor_angles(i) = max(max(conv_gabor_log_fft1)) ;
end

% convert all angles raians to degrees
gabor_angles = rad2deg(angle(gabor_angles));

% get the max of all orientation
max_gabor_angle= max(gabor_angles);

% get the index of the oriantation
theta_blur_idx = find(gabor_angles==max_gabor_angle);

% find the angle of the blur
theta_blur = theta(theta_blur_idx);
gabor_found_kernel = gabor(wavelength,theta_blur);

% generate filter with the estimated angle
h11 = fspecial('motion', L1, theta_blur);

% apply wiener filter to reconstruct the image
wnr_deblur_camera_man_1 = deconvwnr(motion_blur_camera_man1, h11);

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
title('motion blur L=20 theta=30');
fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(gabor_found_kernel.SpatialKernel);
txt=['gabor prediction ' ' theta = ' ,num2str(theta_blur)];
title(txt);
fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(wnr_deblur_camera_man_1));
title('wiener resault');

