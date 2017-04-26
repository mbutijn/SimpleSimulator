% Get the performance from 26 April 2017
performance = load('April 26 2017, 1734');
error = performance.e;
control = performance.u_s;

% Get rid of the transient behaviour
% first_entry = 262;
first_entry = 524; % this is the data from the first 13.08 seconds

% Display some performance results:
disp(strcat('variance of the error signal is:',32,num2str(var(error(first_entry:end)))));
disp(strcat('variance of the control signal is:',32,num2str(var(control(first_entry:end)))));

% Get the table with frequencies, Amplitudes and phase delays
if ~exist('matrix','var')
    matrix = getSignalMatrix;
end

% Make the target forcing functions with a sample frequency of 20 Hz
if ~exist('ft','var') || ~exist('omega_m','var')
    makeSignal(0.05, matrix);
end

% Fourier Transforms
FT = fft(ft(first_entry:end)); % [j*omega]
Sftft = FT.*conj(FT); % PSD

% Error
E = fft(error(first_entry:end));
See = E.*conj(E);

% Control
U = fft(control(first_entry:end));
Suu = U.*conj(U);

% Pilot power spectral density from direct division
H_pilot_d = U./E;

%% Plot the frequencies
% Gain
figure(6);
clf
subplot(2,1,1);
set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log');
hold on;
loglog(matrix(:,2).*omega_m, abs(H_pilot_d(matrix(:,2)+1)),'r*'); % frequencies of target function
loglog(matrix(:,6).*omega_m, abs(H_pilot_d(matrix(:,6)+1)),'b*'); % frequencies of disturbance function
legend('forcing','disturbance','Location','northwest');
xlabel('\omega [rad/s]');
ylabel('|H(j\omega)|');
xlim([0.1 30])
title('Gain human pilot');
hold off

% Phase
subplot(2,1,2);
set(gca, 'XScale', 'log');
hold on
phase_diffs_t = angle(H_pilot_d(matrix(:,2)+1));
semilogx(matrix(:,2).*omega_m, rad2deg(unwrap2(phase_diffs_t,0.75*pi)),'r*');
phase_diffs_d = angle(H_pilot_d(matrix(:,6)+1));
semilogx(matrix(:,6).*omega_m, rad2deg(unwrap2(phase_diffs_d,0.75*pi)),'b*');
legend('forcing','disturbance','Location','southwest');
xlabel('\omega [rad/s]');
ylabel('\angle H [deg]');
xlim([0.1 30])
title('Phase delay human pilot');
hold off