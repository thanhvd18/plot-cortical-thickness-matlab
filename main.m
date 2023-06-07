

regions = 202;
% corticalThicknesses =  rand(regions,1);
% load('sample.mat')
% mean = readtable("mean.layer.0.csv", opts);
%prepare .csv 
table = readtable('mean.layer.1.csv')
corticalThicknesses = double(table2array(table(:,2)));
corticalThicknesses = reshape(corticalThicknesses,regions,1);
cmin = min(corticalThicknesses(:));
cmax = max(corticalThicknesses(:));
show_single_brainmap(corticalThicknesses,cmin,cmax)

%%
middleValue = (cmin+cmax)/2;
range_thresh = 0.2;
cmap = mycolormap(middleValue,range_thresh);
colormap(cmap);
colorbar off