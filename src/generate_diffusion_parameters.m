function [alpha, threshold, D] = generate_diffusion_parameters(indata, prior, distance, base_D)

% prior[1] = 0: uniform, prior[1] = 1: normal. 
  
    data = indata;
    alpha = 5*rand - 2;
    percentile = 100*rand();
    threshold = prctile(nonzeros(data), percentile);
    
    if distance == 1
        data(find(indata > threshold)) = 0;
        data(find(indata <= threshold)) = 1;
    else
        data(data > threshold) = 1;
        data(data <= threshold) = 0;
    end
    D = base_D*exp(alpha*data);
end