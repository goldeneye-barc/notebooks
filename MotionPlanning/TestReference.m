%% INPUT
Xa = 1;
Ya = 1;
Xb = 3;
Yb = 6;
theta = (9*pi)/8;

%% CALCULATE STARTING PARAMETERS
a3 = Xa;
a2 = cos(theta);
b3 = Ya;
b2 = sin(theta);

%% PLOT SOME REFERENCE TRAJECTORIES
figure
hold on
plot(Xa,Ya, 'or',Xb,Yb,'ok')
legend('starting point','endpoint')
title('Reference Trajectories with distance travelled as free parameter')
q = quiver(Xa,Ya,cos(theta),sin(theta), 'r')
% set(q, 'AutoScale', 'on','AutoScaleFactor',2)
set(q,'LineWidth',4)
for tf = 0.1:1:100
    a1 = (Xb - a2*tf - a3)/(tf^2);
    b1 = (Yb - b2*tf - b3)/(tf^2);
    x = @(t) a1*t.^2 + a2.*t + a3;
    y = @(t) b1*t.^2 + b2.*t + b3;
    t = linspace(0,tf,100);
    X = x(t);
    Y = y(t);
    plot(X,Y);
    hold on
end

%% PLOT RADIUS OF CURVATURE, SOLVE OPTIMIZATION PROBLEM
figure
hold on
title('$$|\frac{1}{R(tf)}|$$ different distance travelled','interpreter','latex')
Rmin = 1;
Tf = 60;
for tf = 0.1:1:100
    a1 = (Xb - a2*tf - a3)/(tf^2);
    b1 = (Yb - b2*tf - b3)/(tf^2);
    x = @(t) a1*t.^2 + a2.*t + a3;
    y = @(t) b1*t.^2 + b2.*t + b3;
    t = linspace(0,tf,100);
    K = @(t) (((2*a1.*t+ a2).^2 + (2*b1.*t + b2).^2).^(3/2))./(2*a2*b1 - 2*b2*a1);
    Ks = K(t);
    if (min(abs(Ks)) > Rmin) && (tf < Tf)
        Tf = tf ;
        Kmin = min(abs(Ks));
    end
    plot(t,abs(1./Ks));
    ylim([0,10]);
    hold on
end

%% FINAL REFERENCE TRAJECTORY

a1 = (Xb - a2*Tf - a3)/(Tf^2);
b1 = (Yb - b2*Tf - b3)/(Tf^2);
x = @(t) a1*t.^2 + a2.*t + a3;
y = @(t) b1*t.^2 + b2.*t + b3;
t = linspace(0,Tf,100);
X = x(t);
Y = y(t);
figure
plot(X,Y)
tstring = ['Final Reference trajectory: Rmin = ',num2str(Kmin),' Tf =',num2str(Tf)];
title(tstring)

