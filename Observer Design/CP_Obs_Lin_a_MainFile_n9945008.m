%Clear Workspace
clearvars; close all; clc;

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
observableStates = obsv(Aa,Ca);

if rank(observableStates) == length(Aa)
    disp("This System is Observable")
else
    fprintf("This system has %d observable states", length(Aa) - rank(observableStates))
end

%% Place Poles
Ka = place(Aa,Ba, [-3,-4,-5,-6]);
La = place(Aa',Ca', [-63,-64,-65,-66])';




x1_bar = 0;
x2_bar = 0;
x3_bar = 0;
x4_bar = 0;
K_NL = Ka;
A_NL = Aa;
B_NL = Ba;
C_NL = Ca;
D_NL = Da;
L_NL = La;
setPoint = 0;





%% Simulate Models
x0 = [0.2 20*pi/180 0 0]';
sim('CP_Obs_Lin_a_n9945008');
sim('CP_Obs_NLin_n9945008');

%% Plot Results
figure
hold on

subplot(5,1,1)
hold on
plot(t,x1)
plot(ta,x1a)
plot(ta,x1hat)
plot(ta,x1ahat)
title('x')
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
hold off

subplot(5,1,2)
hold on
plot(t,x2)
plot(ta,x2a)
plot(ta,x2hat)
plot(ta,x2ahat)
title('\theta')
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
hold off

subplot(5,1,3)
hold on
plot(t,x3)
plot(ta,x3a)
plot(ta,x3hat)
plot(ta,x3ahat)
title('Cart Velocity');
legend('Non-Linear','Linear','Non-Linear Estimate','Linear Estimate')
hold off

subplot(5,1,4)
hold on
plot(t,x4)
plot(ta,x4a)
plot(ta,x4hat)
plot(ta,x4ahat)
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







