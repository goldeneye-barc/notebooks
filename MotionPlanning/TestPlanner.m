function [PathX,PathY] = Planner2(X,Y,Psi,ObstacleX,ObstacleY,goalX,goalY)
R_Max = 3.5 % Max turning radius
obstcl_size = 2;

Robj = sqrt((ObstacleX-X)^2+(ObstacleY-Y)^2);
Rgoal = sqrt((goalX-X)^2+ (goalY-Y)^2);

if Robj < Rgoal
    if Robj < 2* R_Max
        theta = acos(Robj/(2*R_Max));
        thetas = linspace(-theta,theta, 21);
    else 
        thetas = linspace(0,2*pi,50)
    end
    
    dist_min = 1e9;
    theta_best = -100;
    x_opt = 0;
    y_opt = 0;
    for i = 1:length(thetas)
        thet = thetas(i);
        xt = Robj*cos(thet) + X;
        yt = Robj*sin(thet) + Y;
        distance = sqrt((goalX-xt)^2+(goalY-yt)^2);
        if (distance < dist_min) && (sqrt((ObstacleX-xt)^2+(ObstacleY-yt)^2) > obstcl_size)
            dist_min = distance;
            theta_best = thet;
            x_opt = xt;
            y_opt = yt;
        end   
    end
    Xtarget = x_opt;
    Ytarget = y_opt;
    PathX = [Xtarget,goalX];
    PathY = [Ytarget,goalY];

else 
    Xtarget = goalX;
    Ytarget = goalY;
    PathX = [goalX];
    PathY = [goalY];
end

end