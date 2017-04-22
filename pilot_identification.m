clear all;
close all
clc;

addpath('..');

% Get the performance from 22 April 2017
performance = load('April 22 2017, 1809');
error = performance.e;
control = performance.u_s;

% Make the target forcing functions with a sample frequency of 20 Hz
makeSignal;

% Get the table with frequencies, Amplitudes and phase delays
matrix = getSignalMatrix;

% Fourier Transforms
FT = fft(ft); % [j*omega]
Sftft = FT.*conj(FT); % PSD

% Error
E = fft(error);
See = E.*conj(E);

% Control
U = fft(control);
Suu = U.*conj(U);

% Pilot power spectral density from direct division
H_pilot_d = U./E;

%% Plot the frequencies
% Gain
figure(6);
subplot(2,1,1);
set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log')
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
semilogx(matrix(:,2).*omega_m, rad2deg(unwrap(phase_diffs_t)),'r*');
phase_diffs_d = angle(H_pilot_d(matrix(:,6)+1));
semilogx(matrix(:,6).*omega_m, rad2deg(unwrap(phase_diffs_d)),'b*');
legend('forcing','disturbance','Location','southwest');
xlabel('\omega [rad/s]');
ylabel('\angle H [deg]');
xlim([0.1 30])
title('Phase delay human pilot');
hold off