clear; clc; close all;
group6_params;

t = linspace(0, 4.5, 4501);
[y_pd, t] = step(r_deg * T_pd, t);
[y_dl, t] = step(r_deg * T_dl, t);
[u_dl, t] = step(r_rad * CS_dl, t);

figure('Color', 'w', 'Position', [100 100 720 520]);
subplot(2, 1, 1);
plot(t, y_dl, 'b-',  'LineWidth', 1.9); hold on;
plot(t, y_pd, 'm--', 'LineWidth', 1.6);
yline(r_deg, 'k:', 'LineWidth', 1.0);
yline(r_deg * (1 + Mp_max/100), 'r--', 'LineWidth', 1.1);
yline(r_deg * 1.02, 'g:', 'LineWidth', 0.9);
yline(r_deg * 0.98, 'g:', 'LineWidth', 0.9);
grid on; ylabel('Pitch Angle \theta_p [deg]');
title(sprintf('Group %d: Candidate Controller Comparison (10^\\circ Step Response)', group_num));
legend('Double-Lead (M_p = 11.50%, Pass)', 'Double-PD (M_p = 13.78%, Fail)', ...
       'Reference (10^\circ)', 'Max Overshoot (12%)', '\pm2% Band', 'Location', 'SouthEast');

subplot(2, 1, 2);
plot(t, u_dl, 'Color', [0.85 0.33 0.10], 'LineWidth', 1.8);
grid on; xlabel('Time t [s]'); ylabel('Control Signal u(t) [V]');
title(sprintf('Group %d: Double-Lead Differential Control Effort u(t) = V_f - V_b', group_num));
legend(sprintf('u(t) (Peak = %.2f V at t = 0^+; Double-PD is impulsive)', max(abs(u_dl))), 'Location', 'NorthEast');
exportgraphics(gcf, 'figures/fig10_candidate_comparison.pdf');