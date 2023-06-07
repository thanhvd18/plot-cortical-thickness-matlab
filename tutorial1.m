clc, clear, close all;
% Load GIFTI toolbox to read GII format (surface-based data)
% Import surface data of Freesurfer template

% Vertices: Locations of individual points (x, y, z) or nodes that make up a surface mesh

% Faces: Polygons formed by connecting the vertices of a surface mesh model
% Faces are defined by indices that specify which vertices are connected to form each face.
% These indices are usually stored in groups of three, representing the three vertices that form a triangular face.

init;

% Total vertices are 327,684; each hemisphere of the brain has 163,842 vertices
% (We can use a template with a smaller number of vertices)
n_vertices = size(g_mesh.vertices, 1);

figure;
% Plot brain surface without weight
plot(g_mesh)

% Plot brain surface with weight from atlas
% Note that the Schaefer atlas is not symmetric, so we have to read annotations for both the left and right hemisphere brain.

% Read annotation: 101 regions in the left brain (100 regions + medial wall of the brain)
[~, gg_lh1_cdata, lh_mapping_table] = read_annotation('brainspace/lh.Schaefer2018_200Parcels_7Networks_order.annot');
lh_mapping_table

% Read annotation: 101 regions in the right brain (100 regions + medial wall of the brain)
[~, gg_rh1_cdata, rh_mapping_table] = read_annotation('brainspace/rh.Schaefer2018_200Parcels_7Networks_order.annot');
rh_mapping_table

% Each region has a specific ID
lh_atlas_id = lh_mapping_table.table(:, 5);
rh_atlas_id = rh_mapping_table.table(:, 5);

table = readtable('data/mean.layer.0.csv');
corticalThicknesses = double(table2array(table(:, 2)));

% Convert weight of 200 regions to weight on the brain surface
w_left_cdata = zeros(n_vertices / 2, 1);
w_right_cdata = zeros(n_vertices / 2, 1);

for j = 1:size(corticalThicknesses, 1) / 2
  % Vlookup mapping table
  w_left_cdata(find(gg_lh1_cdata == lh_atlas_id(j))) = corticalThicknesses(2*j-1);
  w_right_cdata(find(gg_rh1_cdata == rh_atlas_id(j))) = corticalThicknesses(2*j);
end

final_cdata = [w_left_cdata; w_right_cdata];
gg_mesh.cdata = final_cdata;

figure;
plot(g_mesh, gg_mesh)

