function [data_info, data] = import_raster(filename, graph_on, titles)

    fileID = fopen(filename,'r');
    data_info = fscanf(fileID,'%*s %f',[1,5]);
    fclose(fileID);
    data = dlmread(filename,' ',[6,0, data_info(2)+5, data_info(1)-1]);    
    
    if graph_on == 1
        x_point = data_info(3):data_info(5):data_info(3)+data_info(5)*data_info(2)-1;
        y_point = data_info(4):data_info(5):data_info(4)+data_info(5)*data_info(1)-1;
    
        figure 
        imagesc(x_point,y_point,log(data))
        colorbar
        xlabel('x')
        ylabel('y')
        set(gca,'fontsize',12)
        axis equal
        title(titles)
        axis tight
        fig_filename = [current_folder,'landscape_diffusion\\log_point_irradiance'];
        export_fig([fig_filename,'.png'], '-png','-transparent');
    end
end