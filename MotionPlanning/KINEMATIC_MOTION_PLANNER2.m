%% KINEMATIC MOTION PLANNER2
% Author: Rohan Sinha
close all
clear all
clc
%% Setup model constants
Lr = 1; %in meters
Lf = 1; %in meters
% Set vehicle velocity: 
V = 1;  %in meters/second

%% Setup initial conditions
X0 = 0;
Y0 = 0;
Psi0 = 0;

%% Set Up Goal And Obstacles:
ObstacleX = [5, 8,11];
ObstacleY = [0,-2.5,0];
goalX = 15;
goalY = 0;

%% Find a Path:
[PathX,PathY] = PlannerOuter(X0,Y0,Psi0,ObstacleX,ObstacleY,goalX,goalY);
%% Run simulation
sim('kinematic_obstacle_mpc2.slx')

%% Plot results
figure
plot(X.signals.values,Y.signals.values)
title('position')
figure
plot(XDot.time,XDot.signals.values,YDot.time,YDot.signals.values)
title('speed')
figure 
plot(delta.time,delta.signals.values)
title('delta')
figure
plot(Y.time,Y.signals.values)
title('y')

%% Make A video
f = figure
%%
v = VideoWriter('obstacle_avoid3.avi')
open(v)
for i = 1:3:size(Y.time)

    plot(goalX,goalY,'rx')
    
    hold on
    for j = 1: length(ObstacleX)
        r= rectangle('Position',[ObstacleX(j)-1,ObstacleY(j)-1,2,2],'Curvature',[1 1])
        r.FaceColor = [0,.5,.5];
    end
    legend('Target Position')
    plot(X.signals.values(i),Y.signals.values(i),'ok')
    title('Vehicle Position In Time')
    xlabel('X in meters')
    ylabel('Y in meters')
    DrawRectangle([X.signals.values(i), Y.signals.values(i), 1, .5, Psi.signals.values(i)],'b-');
    %r =rectangle('Position',[X.signals.values(i)-.5, Y.signals.values(i)-.25 1 .5]')
    xlim([0 16])
    ylim([-7 7])
    %r.FaceColor = [60/255, 152/255, 183/255];
    hold off
    F = getframe(f);
    writeVideo(v,F);
end
close(v)
%%
implay('obstacle_avoid3.avi')

