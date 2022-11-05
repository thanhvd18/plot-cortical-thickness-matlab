clc,clear,close all;

regions = 202;
corticalThicknesses =  rand(regions,1);

cmin = min(corticalThicknesses(:));
cmax = max(corticalThicknesses(:));
show_single_brainmap(corticalThicknesses,cmin,cmax)

%%
middleValue = (cmin+cmax)/2;
range_thresh = 0.2;
cmap = mycolormap(middleValue,range_thresh)
colormap(cmap)