%% KINEMATIC VEHICLE SIMULATION
% Author: Rohan Sinha
%% Setup model constants
Lr = 1; %in meters
Lf = 1; %in meters
% Set vehicle velocity: 
V = 5;  %in meters/second

%% Setup initial conditions
X0 = 0;
Y0 = 0;
Psi0 = 0;

%% Create input steering
t = linspace(0,10,1000);
d = ones(size(t))*(pi/6)
delta = [t',d'];

%% Run simulation
sim('kinematic_bycicle.slx')

%% Plot results
figure
plot(X.signals.values,Y.signals.values)
figure
plot(XDot.time,XDot.signals.values,YDot.time,YDot.signals.values)
figure
plot(t,d)
