%Clear Workspace
clearvars; close all; clc;

%% Init parameters
m  = 0.15;
Mc = 0.4;
l  = 0.2;
g  = 9.81;

%% Compute Linearisation Matrices
Ab = [ 0 ,          0           , 1 , 0 ;
       0 ,          0           , 0 , 1 ;
       0 ,     (-(g*m)/Mc)      , 0 , 0 ;
       0 , (-(g*(Mc+m))/(l*Mc)) , 0 , 0 ];
   
Bb = [0;0;1/Mc;1/(l*Mc)];

Cb = [1,0,0,0;
      0,1,0,0];

Db = zeros(2,1);


%% Check Controlability
controllableStates = rank(ctrb(Ab,Bb));

if controllableStates == length(Ab)
    disp("This System is Controllable")
else
    disp("This System is not Controllable")
end


%% Check Observability
observableStates = obsv(Ab,Cb);

if rank(observableStates) == length(Ab)
    disp("This System is Observable")
else
    fprintf("This system has %d observable states", length(Ab) - rank(observableStates))
end
%% Place Poles%% Place Poles
Kb = place(Ab, Bb, [-3,-4,-5,-6]);
Lb = place(Ab',Cb', [-63,-64,-65,-66])';


xbar = [0;pi;0;0];
K_NL = Kb;
A_NL = Ab;
B_NL = Bb;
C_NL = Cb;
D_NL = Db;
L_NL = Lb;



%% Simulate Models
disp('Simulating Systems')

x0 = [0.2 200*pi/180 0 0]';
sim('CP_ContrSys_Lin_b_n9945008');
sim('CP_ContrSys_NLin_n9945008');

%% Plot Results
figure
hold on

subplot(5,1,1)
hold on
plot(t,x1)
plot(tb,x1b)
plot(t,x1hat, '--')
plot(tb,x1bhat,'--')
title('x')
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
ylabel('Distance (m)')
hold off

subplot(5,1,2)
hold on
plot(t,x2*180/pi)
plot(tb,x2b*180/pi)
plot(t,x2hat*180/pi, '--')
plot(tb,x2bhat*180/pi, '--')
title('\theta')
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
ylabel('Angle (Deg)')
hold off

subplot(5,1,3)
hold on
plot(t,x3)
plot(tb,x3b)
plot(t,x3hat, '--')
plot(tb,x3bhat, '--')
title('Cart Velocity');
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
ylabel('Velocity (m/s)')
hold off

subplot(5,1,4)
hold on
plot(t,x4)
plot(tb,x4b)
plot(t,x4hat, '--')
plot(tb,x4bhat, '--')
title('Angular Velocity');
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
ylabel('Angular Velocity (rad/s)')
hold off

subplot(5,1,5)
hold on
plot(t,F)
plot(tb,Fb)
title('Control Force');
legend('Non-Linear','Linear')
ylabel('Force (N)')
hold off







