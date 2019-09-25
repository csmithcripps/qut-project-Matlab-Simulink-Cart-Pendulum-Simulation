%% This function makes an animation of the pendulum on the cart.

function output=Cart_Pendulum_Animation(time,qa,qu,qar,qur)

%  Load the variable from simulation
%  time is the simulation time
%  qa is the position of the cart
%  qu is the angle of the pendulum
%  qar is the equilibrium position of the cart
%  qur is the equilibrium angle of the pendulum

%%
clc;
l=0.2;

disp('Animation started');

%% Auxiliar variables

lc=0.06;                                            % Cart length
hc=0.04;                                            % Cart height
xp1plane=0.5;                                       % 
xp2plane=-0.5;           
yp1plane=-1.5*hc;                     

%% Compute cartesian coordinates of the cart and pendulum


xm = qa + l*sin(qu);    % x-coordinate of the pendulum
ym = l*cos(qu);         % y-coordinate of the pendulum

xmr = qar;                % x-coordinate reference position of the pendulum
ymr = l*cos(qur);                % y-coordinate reference position of the pendulum


%% Allocation space movie

mov(1:length(time)) = struct('cdata',[],'colormap',[]);

%% Dimmension of the figure window for the movie

scrsz = get(0,'ScreenSize');
figmovie=figure('Name','Movie: Pendulum on the cart','Position',[0 0 scrsz(3)*2.5/3 scrsz(3)*1.5/2.9]);

%% Plot the current position of the cart-pendulum and the static ones from the previous declaration to store each frame in variable mov

for k=1:length(time)

%% Set the labels for each frame of the animation

figmovie;clf
axes('NextPlot','replacechildren','tag','plot_axes')
title('Pendulum on the cart','FontSize',18)
xlabel('x [m]','FontSize',18)
ylabel('y [m]','FontSize',18)
text(xp1plane/2+xp2plane/2,-1.4*l,sprintf('Time %0.1f sec',time(k)),'FontSize',18)
hold on;

%% Draw the suporting plane base for the cart

xplane = [xp2plane xp1plane];
yplane = [yp1plane yp1plane];
area(xplane,yplane,'basevalue',-hc,'facecolor',[0.5 .5 0.5]);


%% Initial position of the cart and pendulum

% Pendulum

line([qa(1),xm(1)],[0,ym(1)],'Color','k','LineStyle','--','LineWidth',1);                                       % Pendulum link
plot(qa(1),0,'Marker','o','MarkerEdgeColor','k','LineStyle','--','MarkerFaceColor','w','MarkerSize',20);        % Cart joint
plot(xm(1),ym(1),'Marker','o','MarkerEdgeColor','k','LineStyle','--','MarkerFaceColor','w','MarkerSize',30);    % Pendulum mass 

% Cart body

xp1i = qa(1)+lc;
xp2i = qa(1)-lc;
yp1i = 0;
yp2i = -hc;
area([xp2i;xp1i],[yp1i;yp1i],'basevalue',-hc,'facecolor','w','LineStyle','--');   

% Cart wheels

plot(qa(1)+lc*2/3,-hc,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',30);
plot(qa(1)-lc*2/3,-hc,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',30);

%% Reference position of the cart and pendulum


% Pendulum

line([qar,xmr],[0,ymr],'Color',[0 .7 0],'LineStyle','--','LineWidth',1);                                               % Pendulum link
plot(qar,0,'Marker','o','MarkerEdgeColor',[0 .7 0],'LineStyle','--','MarkerFaceColor','w','MarkerSize',20);        % Cart joint
plot(xmr,ymr,'Marker','o','MarkerEdgeColor',[0 .7 0],'LineStyle','--','MarkerFaceColor','w','MarkerSize',30);        % Pendulum mass

% Cart body

xp1r = lc+qar;
xp2r = -lc+qar;
yp1r = 0;
yp2r = -hc;
area([xp2r;xp1r],[yp1r;yp1r],'basevalue',-hc,'EdgeColor',[0 .7 0],'facecolor','w','LineStyle','--');   

% Cart wheels

plot(lc*2/3+qar,-hc,'Marker','o','MarkerEdgeColor',[0 .7 0],'MarkerFaceColor','w','MarkerSize',30);
plot(-lc*2/3+qar,-hc,'Marker','o','MarkerEdgeColor',[0 .7 0],'MarkerFaceColor','w','MarkerSize',30);


%% Current position of the cart and pendulum

% Pendulum 

line([qa(k),xm(k)],[0,ym(k)],'Color','k','LineWidth',1);                                                    % Pendulum link
plot(qa(k),0,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 .7],'MarkerSize',20);                % Cart joint
plot(xm(k),ym(k),'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',30);                 % Pendulum mass

% Cart body

xp1 = qa(k)+lc;
xp2 = qa(k)-lc; 
yp1 = 0;
yp2 = -hc;
area([xp2;xp1],[yp1;yp1],'basevalue',yp2,'facecolor',[0 0 .7]);

% cart wheels

plot(qa(k)+lc*2/3,-hc,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',30);
plot(qa(k)-lc*2/3,-hc,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',30);

%% x-axis and y-axis limits

xlim([-2.5*l 2.5*l])
ylim([-1.5*l 1.5*l])
grid on
hold off


%% Record frame data
mov(k) = getframe(gcf);

end

%% Create AVI file.

vidObj = VideoWriter('Cart_Pendulum_Animation.avi');      % Create a video object
vidObj.FrameRate = 10;                                    % Set frames per second in video object
open(vidObj);                                             % Open video object
writeVideo(vidObj,mov);                                   % Write the frames mov in video object
close(vidObj)                                             % Close video object


disp('Animation finished - Saved in Cart_Pendulum_Animation.avi')