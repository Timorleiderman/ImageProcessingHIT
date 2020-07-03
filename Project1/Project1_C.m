% Timor Leiderman Project 1 image processing course 2020

% Based on the paper Review of motion Blur Estimation Techniques
function Project1_C
% Motion Blur parameters estimation
% define parameters for angle and length
L1 = 20;
L2 = 40;
alpha = 30;
theta = 0:180;

remove_edges = 4
% find the path to the images
camera_man_path = which('cameraman.tif');
% load the image
camera_man_img = double(imread(camera_man_path));

% get the size of the image
[m, n] = size(camera_man_img);


% its making the image look dark so I just removed the edges
% hann_filter = hann(n,'periodic');
% camera_man_img = double(uint8(camera_man_img.*hann_filter));

% generate filters
h1 = fspecial('motion', L1, alpha);
h2 = fspecial('motion', L2, alpha);

% apply filters
motion_blur_camera_man1 = imfilter(camera_man_img, h1, 'conv', 'circular');
motion_blur_camera_man2 = imfilter(camera_man_img, h2, 'conv', 'circular');

% FFT and remove edges for adge artifacts
camera_man_img_fft = fftshift(fft2(camera_man_img));
motion_blur_camera_man_fft1 = fftshift(fft2(motion_blur_camera_man1(remove_edges:end-remove_edges,remove_edges:end-remove_edges)));
motion_blur_camera_man_fft2 = fftshift(fft2(motion_blur_camera_man2(remove_edges:end-remove_edges,remove_edges:end-remove_edges)));

% calc log spectrum
log_spec_camera_man_fft = abs(log(camera_man_img_fft));
log_spec_camera_man_fft1 = abs(log(motion_blur_camera_man_fft1));
log_spec_camera_man_fft2 = abs(log(motion_blur_camera_man_fft2));

% Radon transform
[R1, xp1] = radon(log_spec_camera_man_fft1, theta);
[R2, xp2] = radon(log_spec_camera_man_fft2, theta);

% find the peak
maxR1 = max(max(R1));
maxR2 = max(max(R2));

% index the peak in the Radon transform
[row_idx1, col_idx1] = find(R1 == maxR1);
[row_idx2, col_idx2] = find(R2 == maxR2);

% find corresponding angle
angle_blur_camera_man1 = theta(col_idx1-1);
angle_blur_camera_man2 = theta(col_idx2-1);

% find local minima in radon transform and generate binery map '1' is
% minima
[R11, xp11] = radon(log_spec_camera_man_fft1, angle_blur_camera_man1);
[R22, xp22] = radon(log_spec_camera_man_fft2, angle_blur_camera_man2);

% find local min
local_min_map_camera_man_radon1 = islocalmin(R11);
local_min_map_camera_man_radon2 = islocalmin(R22);

% index local min
index_local_min_map1 = find(local_min_map_camera_man_radon1 == 1);
index_local_min_map2 = find(local_min_map_camera_man_radon2 == 1);

% average distances between local minima
local_min_map_avg_dist1 = mean(diff(index_local_min_map1));
local_min_map_avg_dist2 = mean(diff(index_local_min_map2));

% calculate L
motion_length_camera_man1 = n/local_min_map_avg_dist1;
motion_length_camera_man2 = n/local_min_map_avg_dist2;

% generate wiener filter with asitmimated parametes
h11 = fspecial('motion', motion_length_camera_man1, angle_blur_camera_man1);
h22 = fspecial('motion', motion_length_camera_man2, angle_blur_camera_man2);
% h11 = fspecial('motion', L1, alpha); % this is the good values if the radon was good it would give us these values 
% h22 = fspecial('motion', L2, alpha);

% apply wiener filter to reconstruct the image
wnr_deblur_camera_man_1 = deconvwnr(motion_blur_camera_man1, h11);
wnr_deblur_camera_man_2 = deconvwnr(motion_blur_camera_man2, h22);

% plot the resaults
fig_h = 4;
fig_w = 3;
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
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(motion_blur_camera_man2));
title('motion blur L=40 theta=30');

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imagesc(uint8(log_spec_camera_man_fft));
title('camera man orig');
axis('off');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imagesc(uint8(log_spec_camera_man_fft1));
txt=['blur L =', num2str(L1), ' theta = ' ,num2str(alpha)];
title(txt);
axis('off');

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx)
imagesc(log_spec_camera_man_fft2);
txt=['blur L =', num2str(L2), ' theta = ' ,num2str(alpha)];
title(txt);
axis('off');

fig_idx  = fig_idx + 2;
subplot(fig_h, fig_w, fig_idx);
plot(R11);
txt=['radon estimated' ' theta = ' ,num2str(angle_blur_camera_man1)];
title(txt);
axis('off');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
plot(R22);
txt=['radon estimated' ' theta = ' ,num2str(angle_blur_camera_man2)];
title(txt);
axis('off');

fig_idx  = fig_idx + 2;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(wnr_deblur_camera_man_1));
txt=['wiener L=',num2str(motion_length_camera_man1), ' theta=' ,num2str(angle_blur_camera_man1)];
title(txt)
fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(wnr_deblur_camera_man_2));
txt=['wiener L=',num2str(motion_length_camera_man2), ' theta=' ,num2str(angle_blur_camera_man2)];
title(txt)

