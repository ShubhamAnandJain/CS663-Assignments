function [filtered] = myNotchFilter(fourier, u, v)
filtered = fourier;
w = int16(7);
total = 2*w+1;
notch = ones(total,total);
for i = 1:w
    notch(1+i:total-1, 1+i:total-1) = 1e-2*notch(1+i:total-1, 1+i:total-1);
end

cx = int16(size(fourier, 1)/2)+1;
cy = int16(size(fourier, 2)/2)+1;

disp_u = u - cx;
disp_v = v - cy;

filtered(cx+disp_u-w:cx+disp_u+w, cy+disp_v-w:cy+disp_v+w) = filtered(cx+disp_u-w:cx+disp_u+w, cy+disp_v-w:cy+disp_v+w).*notch;
filtered(cx-disp_u-w:cx-disp_u+w, cy-disp_v-w:cy-disp_v+w) = filtered(cx-disp_u-w:cx-disp_u+w, cy-disp_v-w:cy-disp_v+w).*notch;