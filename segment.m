function [res, count] = segment(img, hs, hrSeg)
    r = size(img, 1);
    c = size(img, 2);
    
    labels = zeros(r, c);
    count = 0;
    for i=1:r
        for j=1:c
            if labels(i, j)==0
                labels(i, j) = count;
                count = count + 1;
            end
            mini = i-hs; maxi = i+hs; minj = j-hs; maxj = j+hs;
            if mini < 1
                mini = 1;
            end
            if maxi > r
                maxi = r;
            end
            if minj < 1
                minj = 1;
            end
            if maxj > c
                maxj = c;
            end
%             size(repmat(img(i, j, :), [maxi-mini+1, maxj-minj+1]))
%             size(img(mini:maxi, minj:maxj, :))
%             er = sum((repmat(img(i, j, :), [maxi-mini+1, maxj-minj+1]) - img(mini:maxi, minj:maxj, :)).^2, 3);
            er = sum((bsxfun(@minus, img(i, j, :), img(mini:maxi, minj:maxj, :))).^2, 3);
            er = er<(hrSeg^2);
%             if min(min(er))==0
%                 disp(er);
%             end
            temp = false(r, c);
            temp(mini:maxi, minj:maxj) = er;
            labels(temp) = labels(i, j);
%             for k = mini:maxi
%                 for l=minj:maxj
%                     if abs(norm(squeeze(img(i, j, :)) - squeeze(img(k, l, :)))) < hrSeg
%                         labels(k,l) = labels(i, j);
%                     end
%                 end
%             end
        end
        i
    end
    count = count - 1;
    res = labels;
%     for i=1:count
%         cur = (labels==i);
%         red = img(:,:,1);
%         red(cur) = mean(mean(red(cur)));
%         green = img(:,:,2);
%         green(cur) = mean(mean(green(cur)));
%         blue = img(:,:,3);
%         blue(cur) = mean(mean(blue(cur)));
%     end
%     res = zeros(r, c, 3);
%     res(:, :, 1) = red;
%     res(:, :, 2) = green;
%     res(:, :, 3) = blue;
end