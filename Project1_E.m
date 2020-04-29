% Timor Leiderman Project 1 image processing 2020
% Based on the paper On the Cepstrum of Two-Dimensional Functious
clear
% define parameters for angle and length for the blur
L1 = 20;
alpha = 30;

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
camera_man_img_fft = abs(fft2(camera_man_img));
motion_blur_camera_man_fft1 = abs(fft2(motion_blur_camera_man1));

% calc log spectrum
log_spec_camera_man_fft = log(camera_man_img_fft);
log_spec_camera_man_fft1 = log(motion_blur_camera_man_fft1);

% calculate cepstrum
cepstrum_func = fftshift(ifft2(log_spec_camera_man_fft));
cepstrum_func1 = fftshift(ifft2(log_spec_camera_man_fft1));


% find the munimum peak
cep_min= min(cepstrum_func1(:));

% index the row and colum of the minimas
[row_min_idx, col_min_idx] = find (cepstrum_func1 ==  cep_min);

% calculate the length and angle between the peak

% I used the fftshift so the peaks located near the center calculation
% divide by 2 if found 2 peaks for one peak just calc the length
norm_div = 0.5;
if ( length(row_min_idx)==1 )
    row_min_idx(2) = 128;
    col_min_idx(2) = 128;
    norm_div = 0;
end

% length calculated for the 2 peaks avarege if only one peak found then it
% will take the lengh from the center
cep_lenght = (1-norm_div)*(sqrt( (row_min_idx(1) - n/2)^2 + (col_min_idx(1) - m/2)^2 )) + norm_div*sqrt( (row_min_idx(2) - n/2)^2 + (col_min_idx(2) - m/2)^2 );

% anle calc from the first peak
cep_theta = atand( abs( (row_min_idx(1) - n/2 -1) )/ abs( (col_min_idx(1) - m/2 - 1) ) );

% generate filter with estimated parametes
h11 = fspecial('motion', cep_lenght, cep_theta);

% apply wiener filter to reconstruct the image
wnr_deblur_camera_man_1 = deconvwnr(motion_blur_camera_man1, h11);
 
% plot the resaults
fig_h = 3;
fig_w = 2;

figure(1);
fig_idx = 1;
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
imshow(cepstrum_func);
txt=['cepstrum orig'];
title(txt);
axis('off');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(cepstrum_func1);
txt=['cepstrum blur'];
title(txt);
axis('off');

fig_idx  = fig_idx + 2;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(wnr_deblur_camera_man_1));
txt=['wiener L=' num2str(cep_lenght) ' theta=' num2str(cep_theta)];
title(txt);
axis('off');