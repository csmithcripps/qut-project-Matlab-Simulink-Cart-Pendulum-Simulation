%Clear Workspace
clearvars; close all; clc;

%% Init parameters
m  = 0.15;
Mc = 0.4;
l  = 0.2;
g  = 9.81;

%% Compute Linearisation Matrices
Ab = [ 0 ,        0           , 1 , 0 ;
       0 ,        0           , 0 , 1 ;
       0 ,   (-(g*m)/Mc)      , 0 , 0 ;
       0 ,  (-g*(Mc+m))/(l*Mc), 0 , 0 ];
   
Bb = [0;0;1/Mc;1/(l*Mc)];

Cb = eye(4);

Db = zeros(4,1);


%% Check Controlability
controllableStates = rank(ctrb(Ab,Bb));

if controllableStates == length(Ab)
    disp("This System is Controllable")
else
    disp("This System is not Controllable")
end

%% Place Poles
Kb = place(Ab,Bb, [-3,-4,-5,-6]);
K_SF = Kb;
setPoint = pi;

%% Simulate Models
x0 = [0.4 200*pi/180 0 0]';
sim('CP_SFC_Lin_b_n9945008');
sim('CP_SFC_NLin_n9945008');

%% Plot Results
figure
hold on

subplot(5,1,1)
hold on
plot(t,x1)
plot(tb,x1b)
legend('x1','x1b')
hold off

subplot(5,1,2)
hold on
plot(t,x2)
plot(tb,x2b)
legend('x2','x2b')
hold off

subplot(5,1,3)
hold on
plot(t,x3)
plot(tb,x3b)
legend('x3','x3b')
hold off

subplot(5,1,4)
hold on
plot(t,x4)
plot(tb,x4b)
legend('x4','x4b')
hold off

subplot(5,1,5)
hold on
plot(t,F)
plot(tb,Fb)
legend('F','Fb')
hold off







