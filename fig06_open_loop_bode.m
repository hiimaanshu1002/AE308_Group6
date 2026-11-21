clear; clc; close all;
group6_params;

w = logspace(-1, 2.5, 1500);
[mag, phase] = bode(G, w);
mag_dB = 20 * log10(squeeze(mag));
phase_deg = squeeze(phase);

figure('Color', 'w', 'Position', [100 100 700 500]);
subplot(2, 1, 1);
semilogx(w, mag_dB, 'b-', 'LineWidth', 1.8); hold on;
xline(p_motor, 'r--', 'LineWidth', 1.2);
yline(0, 'k:', 'LineWidth', 0.9);
grid on; ylabel('Magnitude [dB]');
title(sprintf('Group %d: Open-Loop Bode Diagram of Plant G(s)', group_num));
legend('Magnitude |G(j\omega)|', sprintf('Motor pole \\omega = %.2f rad/s', p_motor), 'Location', 'NorthEast');

subplot(2, 1, 2);
semilogx(w, phase_deg, 'b-', 'LineWidth', 1.8); hold on;
xline(p_motor, 'r--', 'LineWidth', 1.2);
yline(-180, 'k--', 'LineWidth', 1.0);
grid on; ylabel('Phase [deg]'); xlabel('Frequency \omega [rad/s]');
ylim([-275 -170]);
legend('Phase \angleG(j\omega)', 'Motor corner', '-180^\circ boundary', 'Location', 'SouthWest');
exportgraphics(gcf, 'figures/fig06_ol_bode.pdf');