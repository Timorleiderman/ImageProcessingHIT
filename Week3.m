% Timor Leiderman 16_03_2020
% matlab week 3
% talked about qunatization, uniform, loyd-max etc..
%1/deltax = omega_s_x <= 2omega_x_0; omega 2*pi*f

[x,y] = meshgrid(-2:0.1:2,-2:0.2:2);
f= 2*cos(2*pi*(4*x+6*y));
u = 2:0.1:2;
v = 2:0.2:2;
figure(1)
subplot(1,2,1)
imagesc(u,v,f);

[x,y] = meshgrid(-2:0.01:2,-2:0.02:2);
f= 2*cos(2*pi*(4*x+6*y));
u = 2:0.1:2;
v = 2:0.2:2;
subplot(1,2,2)
imagesc(u,v,f);

RGB = imread(which('peppers.png'));
CMY = 255- RGB;
HSV = rgb2hsv(RGB);
grey = rgb2gray(RGB);
lab = rgb2lab(RGB);

h = 5;
w = 3;
cnt = 1;

figure(2)

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(RGB)
title('RGB image')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(CMY)
title('CMY')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(HSV)
title('HSV')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(RGB(:,:,1))
title('R channel')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(RGB(:,:,2))
title('G channel')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(RGB(:,:,3))
title('B channel')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(RGB(:,:,1))
title('C channel')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(RGB(:,:,2))
title('M channel')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(RGB(:,:,3))
title('Y channel')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(HSV(:,:,1))
title('H channel')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(HSV(:,:,2))
title('S channel')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(HSV(:,:,3))
title('V channel')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(grey)
title('RGB 2 Gray')

subplot(h,w,cnt)
cnt = cnt + 1;
imshow(lab)
title('LAB')
