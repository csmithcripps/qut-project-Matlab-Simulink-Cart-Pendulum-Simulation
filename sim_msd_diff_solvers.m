% Script to simulate the mass-spring-damper system with different solvers

close all
clc
clear all
%% Parameters mass-spring-damper set 1
m=1;
c=1;
b=1;
%% Fixed time steps and stop time
h1=0.01;
h2=0.1;
h3=1;
h4=2;

stoptime =????;
%% Simulation ode1, h=0.01
SimOutput = sim('s_msd','Solver','ode1','FixedStep','h1','StopTime','stoptime');
t_ode1h1 = SimOutput.get('tout');
x1_ode1h1 = SimOutput.get('x1');
x2_ode1h1 = SimOutput.get('x2');
%% Simulation ode1, h=0.1
SimOutput = sim('s_msd','Solver','ode1','FixedStep','h2','StopTime','stoptime');
t_ode1h2 = SimOutput.get('tout');
x1_ode1h2 = SimOutput.get('x1');
x2_ode1h2 = SimOutput.get('x2');
%% Simulation ode1, h=1
SimOutput = sim('s_msd','Solver','ode1','FixedStep','h3','StopTime','stoptime');
t_ode1h3 = SimOutput.get('tout');
x1_ode1h3 = SimOutput.get('x1');
x2_ode1h3 = SimOutput.get('x2');

%% Simulation ode1, h=2
SimOutput = sim('s_msd','Solver','ode1','FixedStep','h4','StopTime','stoptime');
t_ode1h4 = SimOutput.get('tout');
x1_ode1h4 = SimOutput.get('x1');
x2_ode1h4 = SimOutput.get('x2');
%========================================================================================
%% Simulation ode4, h=0.01
SimOutput = sim('s_msd','Solver','ode4','FixedStep','h1','StopTime','stoptime');
t_ode4h1 = SimOutput.get('tout');
x1_ode4h1 = SimOutput.get('x1');
x2_ode4h1 = SimOutput.get('x2');
%% Simulation ode4, h=0.1
SimOutput = sim('s_msd','Solver','ode4','FixedStep','h2','StopTime','stoptime');
t_ode4h2 = SimOutput.get('tout');
x1_ode4h2 = SimOutput.get('x1');
x2_ode4h2 = SimOutput.get('x2');
%% Simulation ode4, h=1
SimOutput = sim('s_msd','Solver','ode4','FixedStep','h3','StopTime','stoptime');
t_ode4h3 = SimOutput.get('tout');
x1_ode4h3 = SimOutput.get('x1');
x2_ode4h3 = SimOutput.get('x2');
%% Simulation ode4, h=2
SimOutput = sim('s_msd','Solver','ode4','FixedStep','h4','StopTime','stoptime');
t_ode4h4 = SimOutput.get('tout');
x1_ode4h4 = SimOutput.get('x1');
x2_ode4h4 = SimOutput.get('x2');
%========================================================================================
%% Plots
%  Figure 1
figure(1)
subplot(4,1,1)
plot(t_ode1h1,x1_ode1h1,t_ode4h1,x1_ode4h1,'r')
ylabel('x_1')
legend('ode1','ode4')
title({'Parameters mass-spring-damper set 1','',' Integration step h=0.01'})
xlim([0 stoptime]);
subplot(4,1,2)
plot(t_ode1h2,x1_ode1h2,t_ode4h2,x1_ode4h2,'r')
ylabel('x_1')
legend('ode1','ode4')
title('Integration step h=0.1')
xlim([0 stoptime]);
subplot(4,1,3)
plot(t_ode1h3,x1_ode1h3,t_ode4h3,x1_ode4h3,'r')
ylabel('x_1')
legend('ode1','ode4')
title('Integration step h=1')
xlim([0 stoptime]);
subplot(4,1,4)
plot(t_ode1h4,x1_ode1h4,t_ode4h4,x1_ode4h4,'r')
ylabel('x_1')
legend('ode1','ode4')
title('Integration step h=2')
xlim([0 stoptime]);
%  Figure 2
figure(2)
subplot(4,1,1)
plot(t_ode1h1,x2_ode1h1,t_ode4h1,x2_ode4h1,'r')
ylabel('x_2')
legend('ode1','ode4')
title({'Parameters mass-spring-damper set 1','','Integration step h=0.01'})
xlim([0 stoptime]);
subplot(4,1,2)
plot(t_ode1h2,x2_ode1h2,t_ode4h2,x2_ode4h2,'r')
ylabel('x_2')
legend('ode1','ode4')
title('Integration step h=0.1')
xlim([0 stoptime]);
subplot(4,1,3)
plot(t_ode1h3,x2_ode1h3,t_ode4h3,x2_ode4h3,'r')
ylabel('x_2')
legend('ode1','ode4')
title('Integration step h=1')
xlim([0 stoptime]);
subplot(4,1,4)
ylabel('x_2')
plot(t_ode1h4,x2_ode1h4,t_ode4h4,x2_ode4h4,'r')
legend('ode1','ode4')
ylabel('x_2')
title('Integration step h=2')
xlim([0 stoptime]);

%==========================================
%% Parameters mass-spring-damper set 2
m=1;
c=1;
b=100;

%% Fixed time steps and stop time

h5=????;
stoptime=????;

%%  Simulation ode4, h5
tstart = tic;
SimOutput = sim('s_msd','Solver','ode4','FixedStep','h5','StopTime','stoptime');
tsim_ode4h5 = toc(tstart);
t_ode4h5 = SimOutput.get('tout');
x1_ode4h5 = SimOutput.get('x1');
x2_ode4h5 = SimOutput.get('x2');
%%  Simulation ode45
tstart = tic;
SimOutput = sim('s_msd','Solver','ode45','StopTime','stoptime');
tsim_ode45 = toc(tstart);
t_ode45 = SimOutput.get('tout');
x1_ode45 = SimOutput.get('x1');
x2_ode45 = SimOutput.get('x2');
%%  Simulation ode15s
tstart = tic;
SimOutput = sim('s_msd','Solver','ode15s','StopTime','stoptime');
tsim_ode15s = toc(tstart);
t_ode15s = SimOutput.get('tout');
x1_ode15s = SimOutput.get('x1');
x2_ode15s = SimOutput.get('x2');
%% Plots
figure(3)
subplot(3,1,1)
plot(t_ode4h5,x2_ode4h5,'.-')
legend('ode4')
ylabel('x_2')
title({'Parameters mass-spring-damper set 2 (Stiff System)','','ode 4 fixed-step time'})
xlim([0 stoptime]);
%
subplot(3,1,2)
plot(t_ode45,x2_ode45,'.-')
legend('ode45')
ylabel('x_2')
title('ode 45 variable-step time')
xlim([0 stoptime]);
%

subplot(3,1,3)
plot(t_ode15s,x2_ode15s,'.-')
legend('ode15s')
xlim([0 stoptime]);
ylabel('x_2')
title('ode 15s variable-step time (stiff)')

%
figure(4)
subplot(3,1,1)
plot(t_ode4h5(1:length(t_ode4h5)-1),diff(t_ode4h5))
legend('ode4')
title({'Parameters mass-spring-damper set 2 (Stiff System)','','ode 4 fixed-step time'})
ylabel('Step time')
xlim([0 stoptime]);
ylim([0 2*h5])
%
subplot(3,1,2)
plot(t_ode45(1:length(t_ode45)-1),diff(t_ode45))
legend('ode45')
ylabel('Step time')
title('ode 45 variable-step time')
xlim([0 stoptime]);
%
subplot(3,1,3)
plot(t_ode15s(1:length(t_ode15s)-1),diff(t_ode15s),'.-')
legend('ode15s')
ylabel('Step time')
title('ode 15s variable-step time (stiff)')
xlim([0 stoptime]);
%Simulation Times
TimeSimSet2=[tsim_ode4h5,tsim_ode45,tsim_ode15s]