function makeSignal(dt, matrix)
% Time [20 Hz]
T = 95;
t = 0:dt:T;
assignin('base','time',t);
assignin('base','N',length(t));

% Define measurement base freqency
T_m = 81.92;
omega_m = 2*pi/T_m; % ~ 0.0767 rad/s
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