clear; clc; close all;
group6_params;

w = logspace(-1, 2.5, 2000);
[mag_G, ph_G]   = bode(G, w);
[mag_pd, ph_pd] = bode(L_pd, w);
[mag_dl, ph_dl] = bode(L_dl, w);

figure('Color', 'w', 'Position', [100 100 720 520]);
subplot(2, 1, 1);
semilogx(w, 20*log10(squeeze(mag_G)),  'k:',  'LineWidth', 1.4); hold on;
semilogx(w, 20*log10(squeeze(mag_pd)), 'm--', 'LineWidth', 1.6);
semilogx(w, 20*log10(squeeze(mag_dl)), 'b-',  'LineWidth', 1.8);
yline(0, 'k-', 'LineWidth', 0.8);
grid on; ylabel('Magnitude [dB]');
title(sprintf('Group %d: Bode Loop-Shaping Construction (Uncompensated vs Candidates)', group_num));
legend('Uncompensated G(s)', 'Design 1: Double-PD L_{PD}(s)', 'Design 2: Double-Lead L_{DL}(s)', 'Location', 'SouthWest');

subplot(2, 1, 2);
semilogx(w, squeeze(ph_G),  'k:',  'LineWidth', 1.4); hold on;
semilogx(w, squeeze(ph_pd), 'm--', 'LineWidth', 1.6);
semilogx(w, squeeze(ph_dl), 'b-',  'LineWidth', 1.8);
yline(-180, 'r--', 'LineWidth', 1.0);
yline(-180 + PM_target, 'g--', 'LineWidth', 1.1);
grid on; ylabel('Phase [deg]'); xlabel('Frequency \omega [rad/s]');
ylim([-275 -40]);
legend('Uncompensated G(s)', 'Design 1: Double-PD', 'Design 2: Double-Lead', ...
       '-180^\circ line', sprintf('Binding PM target (%.2f^\\circ)', PM_target), 'Location', 'SouthWest');
exportgraphics(gcf, 'figures/fig09_design_construction.pdf');