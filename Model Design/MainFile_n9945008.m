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
plot(t,F)
plot(t,x1)
plot(t,x2)
plot(t,x3)
plot(t,x4)
legend('F','x1','x2','x3','x4')
hold off


%%
Cart_Pendulum_Animation(t,x1,x2,0,0)
