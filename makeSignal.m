function makeSignal
% Table 1. Multi-sine forcing function properties
addpath('..');
matrix = getSignalMatrix;

% Time [20 Hz]
T = 81.95;
dt = 0.05;
t = 0:dt:T;
assignin('base','time',t);
assignin('base','N',length(t));

% Base freqency
omega_m = 2*pi/T;
assignin('base','omega_m',omega_m);

% Target target function
ft = zeros(size(t));
for i = 1:10
    ft = ft + matrix(i,4)*sin(matrix(i,2)*omega_m.*t+matrix(i,5));
end

% Store the target function
assignin('base','ft',ft);

% Make the disturbance signal
fd = zeros(size(t));
for j = 1:10
    fd = fd + matrix(j,8)*sin(matrix(j,6)*omega_m.*t+matrix(j,9));
end

% Store the disturbance function
assignin('base','fd',fd);