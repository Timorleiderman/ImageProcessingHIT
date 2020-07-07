% % Timor Leiderman Image Processing course 2020
% Based on Adaptive enhancement for nonuniform illumination
% images via nonlinear mapping

function Project2_B(gui_img_in, sigma_gaus, exp_threshold)
% gui_img_in - input image
% sigma_gaus - sigma for the fspecial gaussian filter
% exp_threshold - exposure threshold [0..1]

% load the image
% img_in = imread('fig1.png');
% img_in = imread('fig2.png');
% img_in = imread('fig6.png');
% img_in = imread('fig7.png');
% img_in = imread('fig7.png');

img_in = imread(char(gui_img_in));

    
% get the size of the image
[h, w, ch] = size(img_in);

% calculate luma
img3vec = double(reshape(img_in,h*w,3));
Yvec = img3vec*[0.2989; 0.578; 0.114];
Y = reshape(Yvec, h, w);

% calculate luma with more lines of code
R_ch = double(img_in(:,:,1));
G_ch = double(img_in(:,:,2));
B_ch = double(img_in(:,:,3));
% Y = zeros(h,w);
% for row = 1 : h
%     for col = 1:w
%         Y(row,col) = 0.2989*R(row,col) + 0.578*G(row,col) + 0.114*B(row,col);
%     end
% end

% L is the backgroung avarage of 3X3 window
L = conv2(Y, ones(3)/9, 'same');
% L = Y
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

% The notation Q(B,A) is the truncated output for a pixel 
% with the value of B when it acts as a neighbor of a pixel A.
Q = zeros(h,w);

h_filter = [1 1 1; 1 0 1; 1 1 1]./8;
B = conv2(Y, h_filter, 'full');
for i = 1 : h-1
   for j = 1 : w-1
       A = Y(i,j);
       PnjdA = Pjnd(i,j);
       
      if ( A < PnjdA)
          Q(i,j) = A - PnjdA;
      elseif ( abs(B(i,j) - A) <= PnjdA )
              Q(i,j) = B(i,j);
      else
             Q(i,j) = A + PnjdA; 
       end
   end
end


%  Gaussian distance weights.
% [X,Y] = meshgrid(-w:w,-w:w);
% G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));

q_gauss_filter = fspecial('gaussian', [3 3], sigma_gaus);
Q_gauss = imfilter(Q, q_gauss_filter, 'conv', 'circular'); 

Yjnd = double(Q_gauss);

Ysym = zeros(h,w);
T = zeros(h,w);
Hlow = zeros(h,w);
Hhigh = zeros(h,w);

%Ysym is the modified luminance by SNRF.

% T represents
% the pixel-wise demarcation between underexposure and
% overexposure

% Hlow works in the first
% case to control the adaptation degree for underexposure
   
% Hhigh serves as the adaptation factor
% in the symmetric version of Naka?Rushton formula

Ymedian = mean2(median(Y))/255;

for i = 1:h
   for j = 1:w
         T(i,j) = ( 1 - Ymedian) / ( 1 + exp( 10*( (Yjnd(i,j)/255)-0.7 ) ));
   end
end

Ymlow = mean( T( T < exp_threshold ) );
Ymhigh = mean( T( T >= exp_threshold ) );

Ynorm = Y./255;
for i = 1:h
   for j = 1:w
        Hlow(i,j) = (Yjnd(i,j)/255) + 0.5*Ymlow;
        Hhigh(i,j) = 2*(Yjnd(i,j)/255)*(1-Ymhigh);
        
        if ((Ynorm(i,j) <= T(i,j)) )
            Ysym(i,j) = ( Ynorm(i,j)/( Ynorm(i,j) + Hlow(i,j)) ) * ( T(i,j) + Hlow(i,j) );
        else
            Ysym(i,j) = ( 1 - (1-Ynorm(i,j))/( 1 - Ynorm(i,j) + Hhigh(i,j)) ) * (1 - T(i,j) + Hhigh(i,j));
        end
   end
end

% because Ysym is streached in the [0 1] region we transform it back to
% uint8
Ysym = Ysym.*255;

% gamma corrected Y
Y_tag = 1 + Y - 0.7;

R_tag = R_ch.*(Ysym./Y);
G_tag = G_ch.*(Ysym./Y);
B_tag = B_ch.*(Ysym./Y);

% reconstruct the gamma corrected
R_tag_sq = R_ch.*( (Y_tag./Y).^( 1 - sqrt(R_ch) ) );
G_tag_sq = G_ch.*( (Y_tag./Y).^( 1 - sqrt(G_ch) ) );
B_tag_sq = B_ch.*( (Y_tag./Y).^( 1 - sqrt(B_ch) ) );

rgbImage_recon = cat(3, R_tag, G_tag, B_tag);
rgbImage_recon_sq = cat(3, R_tag_sq, G_tag_sq, B_tag_sq);


% plot the resaults

fig_h = 1;
fig_w = 2;
fig_idx = 1;

figure(2);
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(img_in));
title('Orig image');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(rgbImage_recon_sq));
title("gamma corrected Y'");


fig_h = 4;
fig_w = 3;
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
imshow(uint8(L));
title('L-bg-avg');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(Pjnd));
title('P JND');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(Q));
title('Q');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(Yjnd));
title('Y_{jnd} filtered');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(T.*255));
title('T ');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(Ysym));
title('Y_{sym} filtered');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(rgbImage_recon));
title('Color reconstruction with Y_{sym}');






