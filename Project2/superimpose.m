% Timor Leiderman 30_04_2020 Propject 2A
% superimpose function based on Illumination Correction of Retinal Images Using Superimpose Low Pass and
% Gaussian Filtering
% inputs
% gray - gray input uint8 image
% lpf_size - low pass filter window size
% gauss_filter_size - gaussian fcpecial filter size
% gauss_std - gaussian fcpecial filter stansard diviation
% fig_num - imshow figure number if set to 0 will not plot

function s = superimpose(gray, lpf_size, gauss_filter_size, gauss_std ,fig_num)
    % get width and height
    [h , w] = size(gray);

    % generate gaussian filter with given parameters
    G_fil = fspecial('gaussian',[gauss_filter_size gauss_filter_size], gauss_std);
    gauss_fil = imfilter(double(gray), G_fil, 'conv', 'circular');

    low_pass = zeros(h,w);
    low_pass(0.5*h-lpf_size:0.5*h+lpf_size,0.5*w-lpf_size:0.5*w+lpf_size) = 1;
    
    gray_fft = fftshift(fft2(gray));
    gray_fft_lpf_filtered = abs(ifft2(fftshift(gray_fft.*low_pass)));
    
    if (fig_num>0)
        figure(fig_num)
        subplot(1,2,1);
        imshow(uint8(gauss_fil));
        txt = ['gauss size=' num2str(gauss_filter_size), 'x ' num2str(gauss_filter_size) ' std=' , num2str(gauss_std)];
        title(txt);
        subplot(1,2,2);
        imshow(uint8(gray_fft_lpf_filtered));
        txt = ['LPF size = ' num2str(lpf_size)];
        title(txt);
    end
    s = gray_fft_lpf_filtered - gauss_fil + mean(gauss_fil);
    
end