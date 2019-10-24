%Clear Workspace
clearvars; close all; clc; clear

%% Init parameters
m  = 0.15;
Mc = 0.4;
l  = 0.2;
g  = 9.81;

%% Compute Linearisation Matrices
Aa = [ 0 ,       0            , 1 , 0 ;
       0 ,       0            , 0 , 1 ;
       0 ,  (-(g*m)/Mc)       , 0 , 0 ;
       0 , ((g*(Mc+m))/(l*Mc)), 0 , 0 ];
   
Ba = [0;0;1/Mc;-1/(l*Mc)];

Ca = [1,0,0,0;
      0,1,0,0];

Da = zeros(2,1);


%% Check Controlability
controllableStates = rank(ctrb(Aa,Ba));

if controllableStates == length(Aa)
    disp("This System is Controllable")
else
    disp("This System is not fully Controllable")
end


%% Check Observability
observableStates = obsv(Aa,Ca);

if rank(observableStates) == length(Aa)
    disp("This System is Observable")
else
    fprintf("This system has %d observable states", length(Aa) - rank(observableStates))
end
%% Place Poles%% Place Poles
Ka = place(Aa,Ba, [-3,-4,-5,-6]);
La = place(Aa',Ca', [-63,-64,-65,-66])';


xbar = [0;0;0;0];
K_NL = Ka;
A_NL = Aa;
B_NL = Ba;
C_NL = Ca;
D_NL = Da;
L_NL = La;



%% Simulate Models
x0 = [0.2 20*pi/180 0 0]';
sim('CP_ContrSys_Lin_a_n9945008');
sim('CP_ContrSys_NLin_n9945008');

%% Plot Results
figure
hold on

subplot(5,1,1)
hold on
plot(t,x1)
plot(ta,x1a)
plot(t,x1hat, '--')
plot(ta,x1ahat,'--')
title('x')
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
hold off

subplot(5,1,2)
hold on
plot(t,x2*180/pi)
plot(ta,x2a*180/pi)
plot(t,x2hat*180/pi, '--')
plot(ta,x2ahat*180/pi, '--')
title('\theta')
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
hold off

subplot(5,1,3)
hold on
plot(t,x3)
plot(ta,x3a)
plot(t,x3hat, '--')
plot(ta,x3ahat, '--')
title('Cart Velocity');
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
hold off

subplot(5,1,4)
hold on
plot(t,x4*180/pi)
plot(ta,x4a*180/pi)
plot(t,x4hat*180/pi, '--')
plot(ta,x4ahat*180/pi, '--')
title('Angular Velocity');
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
hold off

subplot(5,1,5)
hold on
plot(t,F)
plot(ta,Fa)
title('Control Force');
legend('Non-Linear','Linear')
hold off


%% Test with Different initial Conditions
x2_20 = x2;
x2a_20 = x2a;

figure;
hold on
plot(t,x2*180/pi)
plot(ta,x2a*180/pi)


x0 = [0.2 30*pi/180 0 0]';
sim('CP_ContrSys_Lin_a_n9945008');
sim('CP_ContrSys_NLin_n9945008');

hold on
plot(t,x2*180/pi)
plot(ta,x2a*180/pi)


x0 = [0.2 40*pi/180 0 0]';
sim('CP_ContrSys_Lin_a_n9945008');
sim('CP_ContrSys_NLin_n9945008');

hold on
plot(t,x2*180/pi)
plot(ta,x2a*180/pi)

x0 = [0.2 50*pi/180 0 0]';
sim('CP_ContrSys_Lin_a_n9945008');
sim('CP_ContrSys_NLin_n9945008');

hold on
plot(t,x2*180/pi)
plot(ta,x2a*180/pi)

x0 = [0.2 60*pi/180 0 0]';
sim('CP_ContrSys_Lin_a_n9945008');
sim('CP_ContrSys_NLin_n9945008');

hold on
plot(t,x2*180/pi)
plot(ta,x2a*180/pi)
xlim([0,3.5])
legend("20deg NLin", "20deg Lin","30deg NLin", "30deg Lin",...
    "40deg NLin", "40deg Lin","50deg NLin", "50deg Lin","60deg NLin", "60deg Lin")
xlabel("Time (s)")
ylabel("Angle of Pendulum (deg)")




%% Further Edge testing
figure;

x0 = [0.2 50*pi/180 0 0]';
sim('CP_ContrSys_NLin_n9945008');
hold on
plot(t,x2*180/pi)

x0 = [0.2 52*pi/180 0 0]';
sim('CP_ContrSys_NLin_n9945008');
hold on
plot(t,x2*180/pi)

x0 = [0.2 54*pi/180 0 0]';
sim('CP_ContrSys_NLin_n9945008');
hold on
plot(t,x2*180/pi)

x0 = [0.2 56*pi/180 0 0]';
sim('CP_ContrSys_NLin_n9945008');
hold on
plot(t,x2*180/pi)

x0 = [0.2 58*pi/180 0 0]';
sim('CP_ContrSys_NLin_n9945008');
hold on
plot(t,x2*180/pi)

x0 = [0.2 -50*pi/180 0 0]';
sim('CP_ContrSys_NLin_n9945008');
hold on
plot(t,x2*180/pi)

legend("50deg","52deg","54deg","56deg","58deg", "-50deg")
xlabel("Time (s)")
ylabel("Angle of Pendulum (deg)")




