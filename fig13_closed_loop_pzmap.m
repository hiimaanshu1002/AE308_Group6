clear; clc; close all;
group6_params;

cl_poles = pole(T_dl);
cl_zeros = zero(T_dl);

x_lim = -45.0;
y_lim = abs(x_lim) * tand(beta_deg);

figure('Color', 'w', 'Position', [100 100 680 460]);
fill([x_lim, -sigma_req, -sigma_req, x_lim], [y_lim, wd_req, -wd_req, -y_lim], ...
     [0.2 0.75 0.3], 'FaceAlpha', 0.18, 'EdgeColor', 'none'); hold on;
xline(-sigma_req, 'g--', 'LineWidth', 1.3);
plot([0, x_lim], [0,  y_lim], 'g:', 'LineWidth', 1.1);
plot([0, x_lim], [0, -y_lim], 'g:', 'LineWidth', 1.1);

plot(real(cl_poles), imag(cl_poles), 'rx', 'MarkerSize', 11, 'LineWidth', 2.2);
plot(real(cl_zeros), imag(cl_zeros), 'bo', 'MarkerSize', 8,  'LineWidth', 1.8);
xline(0, 'k-', 'LineWidth', 0.8); yline(0, 'k-', 'LineWidth', 0.8);

grid on; xlim([-44 2]); ylim([-15 15]);
xlabel('Real Axis [rad/s]'); ylabel('Imaginary Axis [rad/s]');
title(sprintf('Group %d: Closed-Loop Poles & Zeros vs Admissible s-Plane Region', group_num));
legend('Admissible region', sprintf('Re(s) = -%.2f', sigma_req), '', '', ...
       'Closed-loop poles (all 5 inside)', 'Closed-loop zeros', 'Location', 'NorthWest');
exportgraphics(gcf, 'figures/fig13_cl_pzmap.pdf');