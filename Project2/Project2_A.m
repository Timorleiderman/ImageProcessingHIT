% Timor Leiderman Image Processing course 2020
function Project2_A(gui_img_in, lpf_size, gauss_filter_size, gauss_std)

% define parameters
% lpf_size = 6;
% gauss_filter_size = 20;
% gauss_std = 0.5;

% load rgb of gray image

% img_in = imread('ratinal.jpg');
% img_in = imread('ratinalRGB1.png');
% img_in = imread('rice.png');
% img_in = imread('sunflowerseeds.jpeg');
%  img_in = imread('sunflowerseeds_white_back.jpeg');

 img_in = imread(char(gui_img_in));
 
[h, w, ch] = size(img_in);
if (ch == 3)
    img_gray = rgb2gray(img_in);
else
    img_gray = img_in;
end

% call my superimpose function
superimpose_img = superimpose(img_gray,lpf_size, gauss_filter_size, gauss_std, 1);

% find Otsu threshold
otsu_trash = graythresh(img_gray);
otsu_supimpo_trash = graythresh(uint8(superimpose_img));

% generate binery mask like segmentation
otsu_gray = imbinarize(img_gray, otsu_trash);
otsu_superimpose = ~imbinarize(uint8(superimpose_img), otsu_supimpo_trash);

% plot the resaults
fig_h = 3;
fig_w = 2;
fig_idx = 1;

figure(2);

if (ch == 3)
    subplot(fig_h,fig_w,fig_idx);
    imshow(uint8(img_in));
    txt = 'RGB orig';
    title(txt);
else
    fig_h = fig_h - 1;
    fig_idx = -1;
end

fig_idx  = fig_idx + 2;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(img_gray));
txt = 'gray orig';
title(txt);

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(superimpose_img));
txt = 'superimpose';
title(txt);

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(otsu_gray);
txt = 'Otsu on gray';
title(txt);

fig_idx  = fig_idx + 1;
subplot(fig_h,fig_w,fig_idx);
imshow(otsu_superimpose);
txt = 'superimpose + Otsu';
title(txt);


