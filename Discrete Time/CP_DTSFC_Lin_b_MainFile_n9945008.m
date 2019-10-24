%Clear Workspace
clearvars; close all; clc; clear

%% Init parameters
m  = 0.15;
Mc = 0.4;
l  = 0.2;
g  = 9.81;

%% Compute Linearisation Matrices
Ab = [ 0 ,       0            , 1 , 0 ;
       0 ,       0            , 0 , 1 ;
       0 ,  (-(g*m)/Mc)       , 0 , 0 ;
       0 , (-(g*(Mc+m))/(l*Mc)), 0 , 0 ];
   
Bb = [0;0;1/Mc;1/(l*Mc)];

Cb = eye(4);

Db = zeros(4,1);


%% Define Continuous Time SS model and Convert to Discrete
T_s = 0.03;


sysc = ss(Ab,Bb,Cb,Db);

sysdzoh = c2d(sysc,T_s,'zoh');
Ad = sysdzoh.A;
Bd = sysdzoh.B;
Cd = sysdzoh.C;
Dd = sysdzoh.D;

%% Eigenvalues
lambda = [-3,-4,-5,-6];
dLambda = zeros(4,1);
for i = 1:length(lambda)
    dLambda(i) = exp(lambda(i)*T_s);
end

K_db = place(sysdzoh.A ,sysdzoh.B ,dLambda);
Kb = K_db;


x0 = [0.2 20*pi/180 0 0]';


%% Simulate

sim("CP_DTSFC_Lin_b_n9945008")
sim("CP_SD_SFC_Lin_b_n9945008")

%% Plot Results
figure
hold on

subplot(5,1,1)
hold on
stem(tdb,x1db)
plot(tb,x1b)
title('x')
legend('Discrete','Sampled Time')
ylim([0,0.25])
hold off

subplot(5,1,2)
hold on
stem(tdb,x2db*180/pi)
plot(tb,x2b*180/pi)
title('\theta')
legend('Discrete','Sampled Time')
ylim([-10,20])
hold off

subplot(5,1,3)
hold on
stem(tdb,x3db)
plot(tb,x3b)
title('Cart Velocity');
legend('Discrete','Sampled Time')
ylim([-0.4,0.3])
hold off

subplot(5,1,4)
hold on
stem(tdb,x4db*180/pi)
plot(tb,x4b*180/pi)
title('Angular Velocity');
legend('Discrete','Sampled Time')
ylim([-200,100])
hold off

subplot(5,1,5)
hold on
stem(tdb,Fdb)
plot(tb,Fb)
title('Control Force');
legend('Discrete','Sampled Time')
ylim([-2,2])
hold off










