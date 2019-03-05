    %%

edge = linspace(min(alpha),max(alpha),20);   

figure('pos',[0 0 1500 600])

subplot(1,2,1)
histogram(alpha(1:sample_size), edge)
xlabel('\alpha')
ylabel('Frequency')
set(gca,'fontsize',15)
title('Prior')

subplot(1,2,2)
histogram(alpha_posterior(1:acceptance_rate*sample_size), edge)
xlabel('\alpha')
ylabel('Frequency')
set(gca,'fontsize',15)
title('Posterior')

x = 0:5:150;
pd = fitdist(alpha_posterior(1:acceptance_rate*sample_size),'normal')
posterior = pdf(pd,x);


fig_filename = [current_folder,'landscape_diffusion\lightscape_threshold_diffusion_alpha'];
%export_fig([fig_filename,'.png'], '-png','-transparent');
%save([current_folder,'landscape_diffusion\thresholdlightscape_', sample_size])


edge = linspace(min(threshold),max(threshold),20);
figure ('pos',[0 0 1500 600])

subplot(1,2,1)
histogram(threshold(1:sample_size), edge)
xlabel('\epsilon')
ylabel('Frequency')
set(gca,'fontsize',15)
title('Prior')

subplot(1,2,2)
histogram(threshold_posterior(1:acceptance_rate*sample_size), edge)
xlabel('\epsilon')
ylabel('Frequency')
set(gca,'fontsize',15)
title('Posterior')



fig_filename = [current_folder,'landscape_diffusion\lightscape_threshold_diffusion_threshold'];
%export_fig([fig_filename,'.png'], '-png','-transparent');





%%
        x_point = data_info(3):data_info(5):data_info(3)+data_info(5)*data_info(2)-1;
        y_point = data_info(4):data_info(5):data_info(4)+data_info(5)*data_info(1)-1;
    
        figure 
        imagesc(x_point,y_point,log(lightscapes))
        colorbar
        xlabel('x')
        ylabel('y')
        set(gca,'fontsize',12)
        axis equal
        title(titles{4})
        axis tight
        fig_filename = [current_folder,'landscape_diffusion\log_point_irradiance'];
%        export_fig([fig_filename,'.png'], '-png','-transparent');
        
        
        %%
landscape_hits_posterior = landscape_hits(idx);
figure ('pos',[0 0 1500 600])
subplot(1,2,1)
hist3([alpha_posterior,landscape_hits/1000], [10 10],'CDataMode','auto','FaceColor','interp')
title('Prior')
xlabel('\alpha')
ylabel('Number of light encounters per bat')
colorbar
axis tight
view(2)
set(gca,'fontsize',12)


        
subplot(1,2,2)
hist3([alpha_posterior(1:sample_size*acceptance_rate),landscape_hits(1:sample_size*acceptance_rate)/1000], [10 10],'CDataMode','auto','FaceColor','interp')
title('Posterior')
xlabel('\alpha')
ylabel('Number of light encounters per bat')
colorbar
axis tight
view(2)   
set(gca,'fontsize',12)

fig_filename = [current_folder,'landscape_diffusion\lightscape_threshold_alpha_landscape_hits'];
%export_fig([fig_filename,'.png'], '-png','-transparent');
        
%%
landscape_hits_posterior = landscape_hits(idx);
figure ('pos',[0 0 1500 600])
subplot(1,2,1)
hist3([p_post,landscape_hits(1:sample_size*acceptance_rate)], [10 10],'CDataMode','auto','FaceColor','interp')
xlabel('\alpha')
ylabel('Number of light encounters')
colorbar
axis tight
view(2)

%fig_filename = [current_folder,'landscape_diffusion\lightscape_threshold_diffusion_alpa_threshold'];
%export_fig([fig_filename,'.png'], '-png','-transparent');
        
subplot(1,2,2)
hist3([p_pri,landscape_hits], [10 10],'CDataMode','auto','FaceColor','interp')
xlabel('\alpha')
ylabel('Number of light encounters')
colorbar
axis tight
view(2)        
        
