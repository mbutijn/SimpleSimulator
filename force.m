clear all
close all
clc

disp('kies een massa in de range 1 - 20 kg')
m1=input(' ');
m2=2*m1;
g=9.81;
W1=-g*m1;
W2=-g*m2;
t=linspace(0,40,100);
C_D=0.01;
v1=zeros(1,length(t)-1);
v2=v1;

for i=1:length(t)-1;
    D1(i)=C_D*v1(i).^2;
    D2(i)=C_D*v2(i).^2;
    dv1(i)=(W1+D1(i))*(t(i+1)-t(i))/m1;
    dv2(i)=(W2+D2(i))*(t(i+1)-t(i))/m2;
    v1(i+1)=v1(i)+dv1(i);
    v2(i+1)=v2(i)+dv2(i);
end

plot(t,[v1;v2])
title('valsnelheid','fontsize',14);
xlabel('tijd [s]')
ylabel('snelheid [m/s]')

V_asym1=-sqrt(m1*g/C_D)
V_asym2=-sqrt(m2*g/C_D)