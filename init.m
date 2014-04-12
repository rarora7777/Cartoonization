function [res, count, numPixels] = init(imPath, hs, hr, hsSeg)
    im = imread(imPath);
%     im = im2double(im);
%     To remove later
%     im = imresize(im, 0.3);
%     im = colorspace('RGB->Luv', im);
%     hs = 6;
%     hr = 1;
    r = size(im, 1);
    c = size(im, 2);
    
    im = rgb2hsv(im);
    
    imPad = zeros(r+12, c+12, 3);
    imPad(7:r+6, 7:c+6, :) = im;
    im = imPad;
    
    sRGB = zeros(r+12, c+12, 3);
    sRGB(:,:,1) = meanshift(im(:,:,1), hs, hr);
    sRGB(:,:,2) = meanshift(im(:,:,2), hs, hr);
    sRGB(:,:,3) = meanshift(im(:,:,3), hs, hr);
%     sRGB = meanshiftLuv(im, hs, hr);
    disp('Filtered. Beginning final segmentation procedure...');
    resF = zeros(r, c, 3);
    resF(:, :, 1) = sRGB(7:r+6, 7:c+6, 1);
    resF(:, :, 2) = sRGB(7:r+6, 7:c+6, 2);
    resF(:, :, 3) = sRGB(7:r+6, 7:c+6, 3);
%     res = colorspace('Luv->RGB', res);

%     [res, count, numPixels] = segment(resF, hsSeg);
    res = resF; count=0; numPixels=0;
end