%% 1 STEP MPC VEHICLE CONTROL
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

%% Set Up Reference:
t = [0,1-eps,1,8-eps,8,10-eps];
xt = [100,100,5,5,12,12];
yt = [0,0,5,5,2,2];
Xtarget = [t',xt'];
Ytarget = [t',yt'];
%% Run simulation
sim('kinematic_step_mpc.slx')

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
v = VideoWriter('path_mpc.avi')
open(v)
for i = 1:3:size(Y.time)

    if (Y.time(i) > 1) && (Y.time(i) < 8)
        plot(5,5,'xr')
        legend('Target Position')
    elseif Y.time(i) >= 8
        plot(12,2,'xr')
        legend('Target Position')
    else 
        plot(100,0,'xr')
    end
    hold on
    plot(X.signals.values(i),Y.signals.values(i),'ok')
    title('Vehicle Position In Time')
    xlabel('X in meters')
    ylabel('Y in meters')
    DrawRectangle([X.signals.values(i), Y.signals.values(i), 1, .5, Psi.signals.values(i)],'b-');
    %r =rectangle('Position',[X.signals.values(i)-.5, Y.signals.values(i)-.25 1 .5]')
    xlim([0 14])
    ylim([-4 10])
    %r.FaceColor = [60/255, 152/255, 183/255];
    hold off
    F = getframe(f);
    writeVideo(v,F);
end
close(v)
%%
implay('path_mpc.avi')

