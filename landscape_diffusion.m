close all
%clear all

current_folder = strcat('C:\Users\c1863988\roost_finding\');
filename = strcat(current_folder, 'data\buckfastleigh_data.xlsx');
hit_details = xlsread(filename, 'A:C');

[~,idx] = unique(hit_details(:,1));
detector_location = hit_details(idx,1:2);

%terrain_type = {"dist_a_road_rf", "dist_man_hed_rf", "dist_tree_rf", "point_irradiance"};
%titles = {"Distance to A roads (m)", "Distance to managed hedgerows (m)", "Distance to trees (m)", "Point irradiance"};
%N = [ncols, nrows, xmin, ymin, cellsize]
%[data_info, lightscapes] = import_raster(strcat(terrain_type{4},'.asc'), 0, titles{4});
    
terrain_type = {"dist_a_road_rf", "dist_man_hed_rf", "dist_tree_rf", "point_irradiance"};
titles = {"Distance to A roads (m)", "Distance to managed hedgerows (m)", "Distance to trees (m)", "Point irradiance"};
%N = [ncols, nrows, xmin, ymin, cellsize]
[data_info, lightscapes] = import_raster(strcat(terrain_type{4},'.asc'), 0, titles{4});


roost = [274257, 66207];
acceptance_rate = 0.05;
box = [roost(1)-3000 roost(2)-3000; roost(1)+3000 roost(2)+3000];
sample_size = 10;
base_D = 75.5;
N = 1000;
T = 5000;
dt = 10;
range = 10;
n = length(detector_location);
num_cores = 10;
 

%load("minimum_road.mat")
%%
sample_size = 10;
alpha = zeros(sample_size,1);
threshold = zeros(sample_size,1);
detection_rate = zeros(sample_size,n);
landscape_hits = zeros(sample_size, 1);

tic
poolobj = gcp('nocreate');
if isempty(poolobj)
    parpool(num_cores)
end

parfor j = 1:sample_size    
    [alpha(j), threshold(j), D] = generate_diffusion_parameters(lightscapes, 0, 1, base_D);
    [x,y, landscape_hits(j)] = landscape_dependent_diffusion(D, roost, box, base_D, N, T, dt );
    [detection_rate(j,:),~] = check_detectors(detector_location,range,x,y,n,dt);  
end
toc


        [idx,~] = find(hit_details(:,3)>T,1);
        n_hits = histc(hit_details(1:idx,1),detector_location(:,1));
        actual_prop_hits = n_hits/sum(n_hits);
          
    prop_hits = bsxfun(@rdivide,detection_rate',sum(detection_rate'));
    diff_prop_hits = abs(bsxfun(@minus,prop_hits,actual_prop_hits));
    mean_diff = mean(diff_prop_hits);

    [mean_diff,idx] = sort(mean_diff);
    %sort the hits and roost location by difference from the real value   
    alpha_posterior = alpha(idx);
    threshold_posterior = threshold(idx);

save("lightscape_test.mat")

