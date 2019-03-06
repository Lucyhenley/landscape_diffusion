
function [alpha, D] = generate_diffusion_parameters_log(logdata, prior)

% prior[1] = 0: uniform, prior[1] = 1: normal. 
    global  base_D      
    alpha = 4*rand - 2;    

    D = base_D*exp(alpha*logdata);
end