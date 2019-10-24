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

Ca = eye(4);

Da = zeros(4,1);


%% Define Continuous Time SS model and Convert to Discrete
T_s = 0.03;


sysc = ss(Aa,Ba,Ca,Da);

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

K_da = place(sysdzoh.A ,sysdzoh.B ,dLambda);
Ka = K_da;


x0 = [0.2 20*pi/180 0 0]';


%% Simulate

sim("CP_DTSFC_Lin_a_MainFile_n9945008")
sim("CP_SD_SFC_Lin_a_MainFile_n9945008")

%% Plot Results
figure
hold on

subplot(5,1,1)
hold on
stem(tda,x1da)
plot(ta,x1a)
title('x')
legend('Discrete','Sampled Time')
ylim([0,0.5])
hold off

subplot(5,1,2)
hold on
stem(tda,x2da*180/pi)
plot(ta,x2a*180/pi)
title('\theta')
legend('Discrete','Sampled Time')
ylim([-20,20])
hold off

subplot(5,1,3)
hold on
stem(tda,x3da)
plot(ta,x3a)
title('Cart Velocity');
legend('Discrete','Sampled Time')
ylim([-0.5,1.5])
hold off

subplot(5,1,4)
hold on
stem(tda,x4da*180/pi)
plot(ta,x4a*180/pi)
title('Angular Velocity');
legend('Discrete','Sampled Time')
ylim([-300,100])
hold off

subplot(5,1,5)
hold on
stem(tda,Fda)
plot(ta,Fa)
title('Control Force');
legend('Discrete','Sampled Time')
ylim([-5,10])
hold off










