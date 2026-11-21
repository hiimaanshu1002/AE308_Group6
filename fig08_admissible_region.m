clear; clc; close all;
group6_params;

x_left = -7.0;
y_top  = abs(x_left) * tand(beta_deg);

figure('Color', 'w', 'Position', [100 100 650 440]);
fill([x_left, -sigma_req, -sigma_req, x_left], [y_top, wd_req, -wd_req, -y_top], ...
     [0.2 0.75 0.3], 'FaceAlpha', 0.22, 'EdgeColor', 'none'); hold on;
plot([0, x_left], [0,  y_top], 'k--', 'LineWidth', 1.1);
plot([0, x_left], [0, -y_top], 'k--', 'LineWidth', 1.1);
xline(-sigma_req, 'r-', 'LineWidth', 1.5);
plot([-sigma_req, -sigma_req], [wd_req, -wd_req], 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 6);
plot(0, 0, 'kx', 'MarkerSize', 11, 'LineWidth', 2);

text(-sigma_req - 0.3, wd_req + 0.5, sprintf('Corner: -%.2f \\pm j%.3f', sigma_req, wd_req), 'HorizontalAlignment', 'right');
grid on; xlim([-7 1.5]); ylim([-7 7]);
xlabel('Real Axis [rad/s]'); ylabel('Imaginary Axis [rad/s]');
title(sprintf('Group %d: Admissible s-Plane Region (M_p \\leq 12%%, t_s \\leq 2.50 s)', group_num));
legend('Admissible region', sprintf('\\zeta = %.4f (\\beta = %.2f^\\circ)', zeta_req, beta_deg), ...
       '', sprintf('Re(s) = -%.2f', sigma_req), 'Location', 'NorthEast');
exportgraphics(gcf, 'figures/fig08_admissible_region.pdf');