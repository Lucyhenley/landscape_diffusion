close all
clear all

addpath(genpath('C:\Users\c1863988\roost_finding'))

tic 

D = 75.5; % m^2/s, diffusion rate
T = 3600; %s, total simulation time
dt = 10; %s, length of timestep
t = dt:dt:T; %initialise time vector
range = 10; %radius over which detectors detect
N = 1000; %number of bats
n = 84; %number of detectors
L = 6000; %size of box
%ABC variables:
n_runs = 100000; 
acceptance_rate = 0.01;
location = 'rock_farm';
current_folder = strcat('C:\Users\c1863988\roost_finding\');

   
[det_location,actual_det_rate,actual_prop_hits,actual_roost_location, box] = import_data_no_timestamps(location);

[proposed_roosts, D_out, det_rate] = ABC_generate_trajs(n_runs, [D, D/4], det_location,range, N, T, dt, box);
[mean_diff,proposed_roosts_sorted,D_out] = ABC_sort_trajs(n,n_runs,det_rate,proposed_roosts,D_out, actual_prop_hits);
plot_acceptance_rate(mean_diff, n_runs,current_folder, location)


[roost_guess, std_deviation] = estimate_roost(proposed_roosts_sorted,acceptance_rate,n_runs, actual_roost_location, det_location,current_folder, location, 1)

%%
number_detectors_vs_error(acceptance_rate,n_runs, n, det_rate, proposed_roosts, D_out, actual_prop_hits,actual_roost_location,det_location, current_folder, location)


file_location_name = [current_folder, 'results\', num2str(location) '_',num2str(n_runs),'_trajectories'];
save(file_location_name);
toc

%%


    figure ('pos',[0 0 900 600])
    hold on
    scatter(proposed_roosts(:,1), proposed_roosts(:,2),5,'MarkerFaceColor','c', 'MarkerEdgeColor', 'c')
    scatter(proposed_roosts(1:ceil(acceptance_rate*n_runs),1), proposed_roosts(1:ceil(acceptance_rate*n_runs),2),'MarkerFaceColor','b','MarkerEdgeColor','b')
    scatter(det_location(:,1),det_location(:,2),30,'filled', 'w','MarkerEdgeColor','k','LineWidth',1)
    scatter(actual_roost_location(1),actual_roost_location(2),30,'filled','g','MarkerEdgeColor','k','LineWidth',1)
    scatter(roost_guess(1),roost_guess(2),25,'bs','filled')
    xlabel('x')
    ylabel('y')
    legend('Roost prior','Roost posterior','Detector locations','Actual roost location','Posterior mean','Location','westoutside', 'interpreter','latex')
    legend('boxoff')
    set(gca,'fontsize',12)
    axis equal
    fig_filename = [current_folder,'results\',num2str(location) '_roost_prior_posterior'];
    export_fig([fig_filename,'.png'], '-png','-transparent');