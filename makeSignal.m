function makeSignal
% Table 1. Multi-sine forcing function properties
data = [[ 1   6  0.460 1.397 1.288   5  0.383 0.601 -2.069];
        [ 2  13  0.997 0.977 6.089  11  0.844 0.788  2.065];
        [ 3  27  2.071 0.441 5.507  23  1.764 0.48  -2.612];
        [ 4  41  3.145 0.237 1.734  37  2.838 0.313  3.759];
        [ 5  53  4.065 0.159 2.019  51  3.912 0.331  4.739];
        [ 6  73  5.599 0.099 0.441  71  5.446 0.411  1.856];
        [ 7 103  7.900 0.063 5.175 101  7.747 0.55   1.376];
        [ 8 139 10.661 0.046 3.415 137 10.508 0.753  2.792];
        [ 9 194 14.880 0.036 1.066 171 13.116 0.992  3.288];
        [10 229 17.564 0.033 3.479 226 17.334 1.481  3.381]];

% Time
T = 81.90;
dt = 0.05;
t = 0:dt:T;
assignin('base','time',t);
assignin('base','N',length(t));

% Base freqency
omega_0 = 2*pi/T;

% Target forcing function
ft = zeros(size(t));
for i = 1:10
    ft = ft + data(i,4)*sin(data(i,2)*omega_0.*t+data(i,5));
end

assignin('base','ft',ft);