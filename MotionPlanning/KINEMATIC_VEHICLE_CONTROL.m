%% KINEMATIC VEHICLE CONTROL
% Author: Rohan Sinha
close all
%% Setup model constants
Lr = 1; %in meters
Lf = 1; %in meters
% Set vehicle velocity: 
V = 1;  %in meters/second

%% Setup initial conditions
X0 = 0;
Y0 = 0;
Psi0 = 0;

%% Set Control Constant and Reference:
Kp = 4;
Kd = 0;
Ki = 0;
R = 8;
%% Run simulation
sim('kinematic_control.slx')

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
plot([0,10],[1,1],'r')
title('Vehicle Position In Time')
xlabel('X in meters')
ylabel('Y in meters')
xlim([0 10])
ylim([-5 5])
%%
v = VideoWriter('path2.avi')
open(v)
for i = 1:3:size(Y.time)

    plot(X.signals.values(i),Y.signals.values(i),'ok')
    hold on
    plot([0,10],[1,1],'r')
    title('Vehicle Position In Time')
    xlabel('X in meters')
    ylabel('Y in meters')
    DrawRectangle([X.signals.values(i), Y.signals.values(i), 1, .5, Psi.signals.values(i)],'b-');
    %r =rectangle('Position',[X.signals.values(i)-.5, Y.signals.values(i)-.25 1 .5]')
    xlim([0 10])
    ylim([-5 5])
    %r.FaceColor = [60/255, 152/255, 183/255];
    hold off
    F = getframe(f);
    writeVideo(v,F);
end
close(v)
%%
implay('path.avi')

