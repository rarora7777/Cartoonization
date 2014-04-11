function p=meanshift(im, hs, hr)
    [r, c]=size(im);
    f = im;
    new_f_x = zeros(r,c);
    new_f_y = new_f_x;
    new_f_gray = f;

%     hs = 6;
%     hr = 1;

    c1 = -hs:hs;
    c1 = repmat(c1,(2*hs+1),1);
    r1 = c1';
    es = (r1.^2 + c1.^2) / hs^2;
    index = es>1;
    es = exp(-es);
    es(index) = 0;

    for i = hs+1:r-hs
        for j = hs+1:c-hs
            k = i;
            l = j;
            count = 0;
            flag = 1;
            while (flag~=0)
                count = count + 1;
                rr1 = r1 + k;
                cc1 = c1 + l;

                er = ((f(i,j) - f(k-hs:k+hs,l-hs:l+hs)).^2) / hr^2;
                index = er>1;
                er = exp(-er);
                er(index)=0;

                new_k = sum(sum(rr1.*es.*er)) / sum(sum(es.*er));
                new_l = sum(sum(cc1.*es.*er)) / sum(sum(es.*er));
                shift = sqrt((k-new_k)^2+(l-new_l)^2);
                k = round(new_k);
                l = round(new_l);
                if shift < 1
                    flag=0;
                end

                if (new_k<hs+1 || new_k>r-hs || new_l<hs+1 || new_l>c-hs)
                    k=i;
                    l=j;
                    break;
                end
            end
            er = ((f(i,j) - f(k-hs:k+hs,l-hs:l+hs)).^2)/hr^2;
            er = double(er<=1);
            tem = er .* f(k-hs:k+hs,l-hs:l+hs);
            tem = tem(tem>0);
            tem = median(tem);
            new_f_gray(i,j) = tem;
            new_f_x(i,j) = k;
            new_f_y(i,j) = l;
        end
    end
    p=new_f_gray;
end