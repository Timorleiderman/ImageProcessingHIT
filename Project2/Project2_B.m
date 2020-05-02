% Timor Leiderman Image Processing course 2020
clear

% load the image
img_in = imread('fig1.png');

% get the size of the image
[h, w, ch] = size(img_in);

% calculate luma
img3vec = double(reshape(img_in,h*w,3));
Yvec = img3vec*[0.2989; 0.578; 0.114];
Y = reshape(Yvec, h, w);

% calculate luma with more lines of code
% R = img_in(:,:,1);
% G = img_in(:,:,2);
% B = img_in(:,:,3);
% Y = zeros(h,w);
% for row = 1 : h
%     for col = 1:w
%         Y(row,col) = 0.2989*R(row,col) + 0.578*G(row,col) + 0.114*B(row,col);
%     end
% end

% L is the backgroung avarage of 3X3 window
L = conv2(single(Y), ones(3)/9, 'same');

%calculate luminance adaptation threshold TL
TL = zeros(h,w);
for i = 1:h
   for j = 1:w
      if L(i,j) <= 127
         TL(i,j) = 17*(1-sqrt(L(i,j)/127))+3;
      else
         TL(i,j) = (3/128)*(L(i,j)-127)+3;
      end
   end
end

% the pixel-wise JND will be roughly estimated by TL
Pjnd = TL;


% TODO:
% The notation Q(B,A) is the truncated output for a pixel with the value of B
% gaussian somthing
% Yjnd sum of sothing
% 2.2, 2.3, 2.4 ???

% plot the resaults
fig_h = 2;
fig_w = 2;
fig_idx = 1;

figure(1);
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(img_in));
title('Orig image');
fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(Y));
title('Y channel');
fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(Pjnd));
title('P JND');
