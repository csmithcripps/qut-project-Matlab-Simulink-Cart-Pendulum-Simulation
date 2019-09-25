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

Ca = eye(4);

Da = zeros(4,1);


%% Check Controlability
controllableStates = rank(ctrb(Aa,Ba));

if controllableStates == length(Aa)
    disp("This System is Controllable")
else
    disp("This System is not Controllable")
end

%% Place Poles
Ka = place(Aa,Ba, [-3,-4,-5,-6]);


%% Simulate Models
x0 = [0.2 20*pi/180 0 0]';
sim('CP_SFC_Lin_a_n9945008');
sim('CP_SFC_NLin_n9945008');

%% Plot Results
figure
hold on

subplot(5,1,1)
hold on
plot(t,x1)
plot(ta,x1a)
legend('x1','x1a')
hold off

subplot(5,1,2)
hold on
plot(t,x2)
plot(ta,x2a)
legend('x2','x2a')
hold off

subplot(5,1,3)
hold on
plot(t,x3)
plot(ta,x3a)
legend('x3','x3a')
hold off

subplot(5,1,4)
hold on
plot(t,x4)
plot(ta,x4a)
legend('x4','x4a')
hold off

subplot(5,1,5)
hold on
plot(t,F)
plot(ta,Fa)
legend('F','Fa')
hold off







