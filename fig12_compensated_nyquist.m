clear; clc; close all;
group6_params;

w = logspace(0.1, 2.6, 4000);
[re, im] = nyquist(L_dl, w);
re = squeeze(re); im = squeeze(im);

[Gm, Pm, Wcg, Wcp] = margin(L_dl);
neg_real_cross = -1 / Gm;

figure('Color', 'w', 'Position', [100 100 650 480]);
plot(re, im, 'b-', 'LineWidth', 1.7); hold on;
plot(re, -im, 'b--', 'LineWidth', 1.2);
plot(-1, 0, 'r+', 'MarkerSize', 12, 'LineWidth', 2.2);
plot(neg_real_cross, 0, 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 7);

% Unit circle reference for phase margin
theta_uc = linspace(0, 2*pi, 400);
plot(cos(theta_uc), sin(theta_uc), 'k:', 'LineWidth', 0.9);

grid on; xlim([-1.4 0.3]); ylim([-1.2 1.2]);
xlabel('Real Axis'); ylabel('Imaginary Axis');
title(sprintf('Group %d: Compensated Nyquist Plot of L(s) (N = 0, GM = %.2f, PM = %.2f^\\circ)', ...
      group_num, Gm, Pm));
legend('\omega > 0', '\omega < 0', 'Critical point (-1, 0)', ...
       sprintf('Real-axis crossing (%.4f)', neg_real_cross), 'Unit circle', 'Location', 'SouthWest');
exportgraphics(gcf, 'figures/fig12_compensated_nyquist.pdf');