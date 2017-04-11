%clear all
close all
clc
s=tf('s');
m = 1;
k = 100;
c = 5.0;
%frequency = 0.5*sqrt(2);
%frequency = 0.5868;
frequency = 10*sqrt(k/m);
H = (c*s+k)/(m*s^2+c*s+k);
tau = 0.1;
%H = 1/(1+tau*s);
%H = 1/(1+(2*c*s)/frequency+s^2/frequency^2);
figure(1)
bode(H)
t = [0:0.01:5];
%u = sin(frequency*t);
u=ones(1,length(t));
%u=t*0.05;
%u=[zeros(1,round(0.1*length(t))-1) 30 zeros(1,round(0.9*length(t)))];
%u=rand(1,length(t));
y = lsim(H,u,t);

% c = xcov(y, 'unbiased'); % auto covariance function
% k = c/(std(y)^2);
% movegui(figure(1),'northeast');
% plot(k)

%% Simulation
movegui(figure(2),'northwest');
plot(t,[u;y'])

for i = 1:length(t)
    figure(3)    
    hold on
    plot([0 1 1 0 0],[1.5+y(i) 1.5+y(i) 2.5+y(i) 2.5+y(i) 1.5+y(i)])
    plot([-1 1],[u(i) u(i)]);
    plot([-1 2], [0 0]);
    axis([-1, 2, -1, 5]);
    title(strcat('t =',32, num2str(t(i))));
    M(i) = getframe;
    
    if i ~= length(t)
        clf
    end
end
hold off

%% Write Movie
% movie2avi(M, 'step_input.avi', 'compression', 'none')