clear; clc; close all;
group6_params;

figure('Color', 'w', 'Position', [100 100 650 420]);
p_ol = pole(G);
plot(real(p_ol), imag(p_ol), 'rx', 'MarkerSize', 12, 'LineWidth', 2.2); hold on;
xline(0, 'k-', 'LineWidth', 0.8);
yline(0, 'k-', 'LineWidth', 0.8);

text(-p_motor, 0.8, sprintf('s = -%.4f\n(motor lag)', p_motor), 'HorizontalAlignment', 'center');
text(0.5, 0.8, 'Double pole at s = 0', 'HorizontalAlignment', 'left');

grid on; xlim([-23 5]); ylim([-6 6]);
xlabel('Real Axis [rad/s]'); ylabel('Imaginary Axis [rad/s]');
title(sprintf('Group %d: Open-Loop Pole-Zero Map of G(s) (No Finite Zeros)', group_num));
legend('Open-loop poles (double at 0)', 'Location', 'SouthWest');
exportgraphics(gcf, 'figures/fig01_pzmap.pdf');