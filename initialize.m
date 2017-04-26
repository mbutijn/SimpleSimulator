function initialize
assignin('base', 'i', 1);
assignin('base', 'y', 0);
assignin('base', 'ydot', 0);
assignin('base', 'ydotdot', 0);
assignin('base', 'oldu', 0);
assignin('base', 't', 0);

N = evalin('base', 'N');
assignin('base', 'e', zeros(1, N));
assignin('base', 'u_s', zeros(1, N));
