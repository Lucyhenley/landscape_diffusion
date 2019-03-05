function [x,y,landscape_hits] = landscape_dependent_diffusion(D, roost, box, base_D, N, T, dt )

    IC = zeros(N,2); %initial starting point for each bat
    IC(:,1) = roost(1);
    IC(:,2) = roost(2);
    x = zeros(N, T/dt);
    y = zeros(N, T/dt);
    x(:,:,1) = roost(1);%IC(:,:,1);
    y(:,:,1) = roost(2);
    Rx=[IC(:,1),sqrt(2*dt).*randn(N,T/dt-1)];
    Ry=[IC(:,2),sqrt(2*dt).*randn(N,T/dt-1)];
    landscape_hits = 0;


    for t = 2:T/dt
        for i = 1:N
            if x(i,t-1) <= box(1) +1 || x(i,t-1) >= box(2) || y(i,t-1) <= box(3) + 1 || y(i,t-1) >= box(4)
                x(i,t) = x(i,t-1) + Rx(i,t)*sqrt(base_D);
                y(i,t) = y(i,t-1) + Ry(i,t)*sqrt(base_D); 
            else
                x(i,t) = x(i,t-1) + Rx(i,t)*sqrt(D(round(x(i,t-1)- box(1)), round(y(i,t-1)- box(3))));
                y(i,t) = y(i,t-1) + Ry(i,t)*sqrt(D(round(x(i,t-1)- box(1)), round(y(i,t-1)- box(3)))); 
                if D(round(x(i,t-1)- box(1)), round(y(i,t-1)- box(3))) ~= base_D
                    lanscape_hits = landscape_hits + 1;
                end
            end
        end
    end
 end