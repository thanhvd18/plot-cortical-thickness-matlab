addpath('./gifti')
path_annot_lh = 'brainspace/lh.Schaefer2018_200Parcels_7Networks_order.annot';
path_annot_rh = 'brainspace/rh.Schaefer2018_200Parcels_7Networks_order.annot';


g_mesh = gifti('brainspace/mesh.inflated.freesurfer.gii')
g_lh = gifti('brainspace/lh.inflated.freesurfer.gii')
g_rh = gifti('brainspace/rh.inflated.freesurfer.gii')

