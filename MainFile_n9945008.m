%Clear Workspace
clearvars; close all;

%% Init parameters
m  = 0.15;
Mc = 0.4;
l  = 0.2;
g  = 9.81;


%% Run Simulation
sim('Cart_Pendulum_n9945008.slx')


%% Plot Results
figure
hold on
plot(tout,F)
plot(tout,x1)
plot(tout,x2)
plot(tout,x3)
plot(tout,x4)
legend('F','x1','x2','x3','x4')
hold off