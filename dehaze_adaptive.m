function J = dehaze_adaptive(I)

	patchSize = 15;
    src = im2double(I);
    darkchannel = get_dark_channel(src,patchSize);
    A = get_atmosphere(src, darkchannel);
    [height, width, ~] = size(src);
    hsv = rgb2hsv(src);
    d = zeros(height, width);

    d(:,:) =  0.0910 + 0.6960 * hsv(:,:,3)  -0.7198 * hsv(:,:,2);


    new_d = d;

     r = 15;
    res = 0.001;

    guidedfilter_d = guided_filter(rgb2gray(src), new_d, r, res);

    J = our_recover_with_gamma_corr(src, A, guidedfilter_d);

end