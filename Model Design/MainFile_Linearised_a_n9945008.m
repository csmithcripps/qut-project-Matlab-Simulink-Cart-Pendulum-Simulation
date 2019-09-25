%Clear Workspace
clearvars; close all;

%% Init parameters
m  = 0.15;
Mc = 0.4;
l  = 0.2;
g  = 9.81;


%% Run Simulation
sim('Cart_Pendulum_Linearised_a_n9945008.slx')


%% Plot Results
figure
hold on
plot(ta,x1a)
plot(ta,x2a)
plot(ta,x3a)
plot(ta,x4a)
legend('x1','x2','x3','x4')
hold off