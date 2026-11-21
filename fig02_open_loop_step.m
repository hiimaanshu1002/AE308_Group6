clear; clc; close all;
group6_params;

t = linspace(0, 3.0, 600);
[y_ol, t] = step(G, t);
y_double_int = 0.5 * K0 * t.^2;

figure('Color', 'w', 'Position', [100 100 650 420]);
plot(t, y_ol, 'b-', 'LineWidth', 2.0); hold on;
plot(t, y_double_int, 'k--', 'LineWidth', 1.4);

grid on;
xlabel('Time t [s]'); ylabel('Pitch Angle \theta_p [rad] for u = 1 V Step');
title(sprintf('Group %d: Open-Loop Step Response (Unbounded)', group_num));
legend('Plant response \theta_p(t)', 'Double-integrator limit K_0 t^2 / 2', 'Location', 'NorthWest');
exportgraphics(gcf, 'figures/fig02_ol_step.pdf');