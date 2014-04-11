function res= init(imPath, hs, hr)
    im = imread(imPath);
    im = im2double(im);
%     To remove later
    im = imresize(im, 0.3);
%     im = colorspace('RGB->Luv', im);
%     hs = 6;
%     hr = 1;
    r = size(im, 1);
    c = size(im, 2);
    
    imPad = zeros(r+12, c+12, 3);
    imPad(7:r+6, 7:c+6, :) = im;
    im = imPad;
    
    sRGB = zeros(r+12, c+12, 3);
%     sRGB(:,:,1) = meanshift(im(:,:,1), hs, hr);
%     sRGB(:,:,2) = meanshift(im(:,:,2), hs, hr);
%     sRGB(:,:,3) = meanshift(im(:,:,3), hs, hr);
    sRGB = meanshiftLuv(im, hs, hr);
    
    res = zeros(r, c, 3);
    res(:, :, 1) = sRGB(7:r+6, 7:c+6, 1);
    res(:, :, 2) = sRGB(7:r+6, 7:c+6, 2);
    res(:, :, 3) = sRGB(7:r+6, 7:c+6, 3);
    res = colorspace('Luv->RGB', res);
end