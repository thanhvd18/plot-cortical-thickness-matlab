function [] = show_single_brainmap(corticalThicknesses,cmin, cmax)
% 
% @author: thanhvd18
% 
init;
[~,gg_lh1_cdata,a] = read_annotation(path_annot_lh);
atlas_id = a.table(:,5);



figure1 = figure;
% Create axes
axes1 = axes('Parent',figure1);
axis off

topLeftTarget = {[-33 -1160.4 -67.6], [-33 -696.5 -69], [-33 -196.4 -63.26], [-33 309.4 -63.3], [-33 829.7 -63.2]}
topRightTarget = {[-33 860.25 -67.9], [-33 374.45 -63.6], [-33 -143.2 -63.6], [-33 -670.89 -63.56], [-33 -1182.7 -60.7]}
bottomLeftTarget =  {[-33 -1126.4 135.4], [-33 -678.99 138.2], [-33 -189.5 141], [-33 298.6 141],[-33 800.7 142.4]}
bottomRightTarget = {[33 857.9 140.4], [33 371.1 140.4], [33 -138.73 141.84], [33 -671.6 143.3], [33 -1185.8 138.96]}
centerTarget = {[1017.5 7 16], [534.727 9.9 16],[27.3 14.25 16], [-490 9.9 16], [-1006.4 14.25 16]}

topLeftCamera = {[-2604 -1160.4 -67.6], [-2604 -696.5 -69], [-2604 -196.4 -63.26], [-2604 309.4 -63.3], [-2604 829.7 -63.2]}
topRightCamera = {[2539 860.25 -67.9], [2539 374.45 -63.6], [2539 -143.2 -63.6], [2539 -670.89 -63.56], [2539, -1182.7 -60.7]}
bottomLeftCamera = {[-2528 -1126.4 135.4], [-2528 -678.99 138.2], [-2528 -189.5 141], [-2528 298.6 141], [-2528 800.7 142.4]}
bottomRightCamera = {[2595 857.9 140.4], [2595 371.1 140.4], [2595 -138.73 141.84], [2595 -671.6 143.3], [2595 -1185.8 138.96]}
centerCamera = {[1017.5 7 2595], [534.727 9.9 2595], [27.3 14.25 2595], [-490 9.9 2595], [-1006.4 14.25 2595]}
scale = 7
i=3;
    cdata_i = corticalThicknesses;
%     cdata_i = min_max_normalize(cdata_i,thresh_per);
    w_left_cdata  = zeros(size(gg_lh1_cdata));
    w_right_cdata = zeros(size(gg_lh1_cdata));

    for j=1:size(corticalThicknesses,1)/2
      w_left_cdata(find(gg_lh1_cdata == atlas_id(j))) = cdata_i(2*j-1);
      w_right_cdata(find(gg_lh1_cdata == atlas_id(j))) = cdata_i(2*j);
    end
    final_cdata = [w_left_cdata;w_right_cdata];
    gg_mesh.cdata = final_cdata;
    gg_lh.cdata = final_cdata(1:size(final_cdata,1)/2);
    gg_rh.cdata = final_cdata(size(final_cdata,1)/2+1:end);
    gg_rh = gifti(gg_rh);
    gg_lh = gifti(gg_lh);
    plotObjs_lh1 = plot(g_lh,gg_lh); %top left
    view(90,360)
    caxis([cmin, cmax]);
    set(gca,'CameraViewAngle', scale)
    set(gca,'CameraPosition',topLeftCamera{i})
    set(gca,'CameraTarget',topLeftTarget{i})
    
    
    c = colorbar;
    caxis([cmin, cmax]);

    c.Position = [0.019 0.191 0.014 0.61];

    plotObjs_rh2 = plot(g_rh,gg_rh); %bottom left
%     view(270,0)
    view(90,360)
    caxis([cmin, cmax]);
    set(gca,'CameraViewAngle', scale)
    set(gca,'CameraPosition', bottomLeftCamera{i})
    set(gca,'CameraTarget',bottomLeftTarget{i})

    plotObjs_lh1 = plot(g_lh,gg_lh); %bottom right
    caxis([cmin, cmax]);
    view(90,360)
    set(gca,'CameraViewAngle', scale)
    set(gca,'CameraPosition', bottomRightCamera{i})
    set(gca,'CameraTarget',bottomRightTarget{i})

    plotObjs_rh2 = plot(g_rh,gg_rh); % top right
%     view(270,0)
    view(90,360)
    caxis([cmin, cmax]);
    set(gca,'CameraViewAngle', scale)
    set(gca,'CameraPosition',topRightCamera{i} )
    set(gca,'CameraTarget',topRightTarget{i})

    plotObjs_mesh = plot(g_mesh,gg_mesh); %center
    view(0,90)
    caxis([cmin, cmax]);
    set(gca,'CameraViewAngle', scale)
    set(gca,'CameraPosition',centerCamera{i})
    set(gca,'CameraTarget',centerTarget{i})
end





