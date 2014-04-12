function [res, count, numPixels] = segment(img, hrSeg)
    r = size(img, 1);
    c = size(img, 2);
    
    labels = zeros(r, c);
    begi = zeros(r, c);
    begj = zeros(r, c);
    count = 1;
    
    numPixels = zeros(10000, 1);
    sumColors = zeros(10000, 3);
    
    red = img(: , : ,1);
    green = img(: , : ,2);
    blue = img(: , : ,3);
    
    for i=1:r
%         mini = i - hs; maxi = i + hs;
%         
%         if mini < 1
%                 mini = 1;
%         end
%         if maxi > r
%             maxi = r;
%         end
        
        for j=1:c
            if labels(i, j)==0
                labels(i, j) = count;
                numPixels(count) = 1;
                sumColors(count, :) = img(i, j, :);
                count = count + 1;
                begi(i, j) = i; begj(i, j) = j;
            else
%                 disp('Skipped');
                continue;
            end
%             minj = j - hs; maxj = j + hs;
            
%             if minj < 1
%                 minj = 1;
%             end
%             if maxj > c
%                 maxj = c;
%             end

%             er = sum((bsxfun(@minus, img(begi(i, j), begj(i, j), :), img(mini:maxi, minj:maxj, :))).^2, 3);
%             er = er<(hrSeg^2);
%             temp = false(r, c);
%             temp(mini:maxi, minj:maxj) = er;
%             labels(temp) = labels(i, j);
%             begi(temp) = i; begj(temp) = j;
            oldPixels = 1; newPixels = 0;
            while(oldPixels~=newPixels)
                curLabel = labels(i, j);
                oldPixels = sum(sum(labels==curLabel));
                curColor = reshape(sumColors(curLabel, :)/oldPixels, [1 1 3]);
    %             curColor
    %             tic
    %             er = sum((bsxfun(@minus, img(begi(i, j), begj(i, j), :), img(:, : , :))).^2, 3);
                er = sum((bsxfun(@minus, curColor, img(:, : , :))).^2, 3);
    %             toc
                er = er<(hrSeg^2);
                labels(er) = labels(i, j);
                begi(er) = i; begj(er) = j;

                numPixels(curLabel) = numPixels(curLabel) + sum(sum(er));
                sumColors(curLabel, 1) = sumColors(curLabel, 1) + sum(red(er));
                sumColors(curLabel, 2) = sumColors(curLabel, 2) + sum(green(er));
                sumColors(curLabel, 3) = sumColors(curLabel, 3) + sum(blue(er));

                newPixels = sum(sum(labels==curLabel));
                
%                 squeeze(img(i, j, :))'
%                 sumColors(curLabel, :)/newPixels
            end
        end
%         i
    end
    count = count - 1;
%     res = labels;
    
    for i=1:count
        cur = (labels==i);
        red(cur) = mean(red(cur));
        green(cur) = mean(green(cur));
        blue(cur) = mean(blue(cur));
    end
    
    res = zeros(r, c, 3);
    res(:, :, 1) = red;
    res(:, :, 2) = green;
    res(:, :, 3) = blue;
    
end