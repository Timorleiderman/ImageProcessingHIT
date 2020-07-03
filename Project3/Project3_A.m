% Timor Leiderman Image Processing course 2020
% Based on Fast image dehazing using guided joint bilateral filter

function Project3_A(gui_img_in)

%deefine variables
% p -> [0 ... 1]
p = 0.6;
omega = 0.95;
% window size

% load the image
rgb_img_in = double(imread(gui_img_in));

sigma = std2(rgb_img_in)/100;
sigma = 5;
% get the size of the image
[h, w, ch] = size(rgb_img_in);

% window_size  = (2*(max(h,w)/50))+1;
window_size  = 9;
% W is the minimum of the tree channels

% W = zeros(h,w);
% for row=1:h
%     for col=1:w
%         W(row, col) = min(rgb_img_in(row, col, :));
%     end
% end

C_sum = sum(sum(rgb_img_in(:,:,:)));
[min_C, min_idx] = min (C_sum);
W = rgb_img_in(:,:,min_idx);


B = medfilt2(W);

C = B - medfilt2(abs(W-B));

V = max( min(C.*p,W), 0);

wind = floor(window_size/2);

[X,Y] = meshgrid(-wind:wind,-wind:wind);
gs = exp(-(X.^2+Y.^2)/(2*sigma^2));


W = padarray(W,[wind wind],'replicate','both');

R = zeros(h,w, 1);
for row=ceil(window_size/2):size(W,1)-wind
    for col=ceil(window_size/2):size(W,2)-wind
        
        patch1(:,:,:)=W(row-wind:row+wind,col-wind:col+wind);
        patch2(:,:,:)=W(row-wind:row+wind,col-wind:col+wind);
        
        d = (repmat(W(row,col,:), [window_size,window_size]) - patch2).^2;
        
        % intensity-domain weights. (range weights)
        gr = exp( -(d) / (2*sigma^2) );
        
        %normalization factor
        g = gs.*gr; 
        %normalization factor
        normfactor = 1/ sum(sum(g)); 
        %apply equation:
        R(row-ceil(window_size/2)+1,col-ceil(window_size/2)+1,1)=sum(sum(g.*patch1))*normfactor;
    end
end
W = W(wind+1:end-wind,wind+1:end-wind);

V = padarray(V,[wind wind],'replicate','both');
R = padarray(R,[wind wind],'replicate','both');

VR=zeros(h,w, 1);

for row=ceil(window_size/2):size(V,1)-wind
    for col=ceil(window_size/2):size(V,2)-wind
        
        patch1(:,:)=V(row-wind:row+wind,col-wind:col+wind);
        patch2(:,:)=R(row-wind:row+wind,col-wind:col+wind);
        
        d = (repmat(R(row,col,:),[window_size,window_size])-patch2).^2;
        
        % intensity-domain weights. (range weights)
        gr = exp( -(d) / (2*sigma^2) );

        %normalization factor
        g = gs.*gr; 
        %normalization factor
        normfactor = 1/ sum(sum(g)); 
        %apply equation:
        VR(row-ceil(window_size/2)+1,col-ceil(window_size/2)+1)=sum(sum(g.*patch1))*normfactor;
       
        
    end
end

V = V(wind+1:end-wind,wind+1:end-wind);
R = R(wind+1:end-wind,wind+1:end-wind);

% seperate image to channels
R_ch = rgb_img_in(:,:,1);
G_ch = rgb_img_in(:,:,2);
B_ch = rgb_img_in(:,:,3);

sum_R = sum(sum(R_ch));
sum_G = sum(sum(G_ch));
sum_B = sum(sum(B_ch));

% find the darkest channel
if (sum_R <= sum_G) && (sum_R <= sum_B)
     darkest = R_ch;
elseif (sum_G <= sum_R) && (sum_G <= sum_B)
     darkest = G_ch;
else
     darkest = B_ch;    
end
   
A = max(max(darkest));

t = 1 - (omega*VR)./A;

t0 = min(min(t));
J = ( (rgb_img_in-A)./max(t,t0) )+ A;


% plot the resaults
fig_h = 3;
fig_w = 3;
fig_idx = 1;

figure(1);
subplot(fig_h,fig_w,fig_idx);
imshow(uint8(rgb_img_in));
title('Orig image');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(W));
title('W min channel');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(B));
title('B median fil');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(C));
title('C median dif');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(V));
title('V');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(R), []);
title('R');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(VR), []);
title('VR');


fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(t.*255));
title('t');

fig_idx  = fig_idx + 1;
subplot(fig_h, fig_w, fig_idx);
imshow(uint8(J));
title('J');