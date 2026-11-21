clear; clc; close all;
group6_params;

w = logspace(-1.2, 2.5, 2500);
[re, im] = nyquist(G, w);
re = squeeze(re); im = squeeze(im);

% Indentation semicircle around origin s = eps * exp(j*theta)
eps_r = 0.25;
theta_ind = linspace(-pi/2, pi/2, 300);
s_ind = eps_r * exp(1j * theta_ind);
H_ind = b_gain ./ (s_ind.^2 .* (s_ind + p_motor));
H_ind_scaled = 2.8 * (H_ind / max(abs(H_ind))); % Visual arc at infinity

figure('Color', 'w', 'Position', [100 100 650 480]);
plot(re, im, 'b-', 'LineWidth', 1.6); hold on;
plot(re, -im, 'b--', 'LineWidth', 1.2);
plot(real(H_ind_scaled), imag(H_ind_scaled), 'g:', 'LineWidth', 1.6);
plot(-1, 0, 'r+', 'MarkerSize', 12, 'LineWidth', 2.2);
xline(0, 'k-', 'LineWidth', 0.8); yline(0, 'k-', 'LineWidth', 0.8);

grid on; xlim([-3.5 3.5]); ylim([-3.5 3.5]);
xlabel('Real Axis'); ylabel('Imaginary Axis');
title(sprintf('Group %d: Indented Open-Loop Nyquist Diagram of G(s)', group_num));
legend('\omega: 0^+ \rightarrow +\infty', '\omega: -\infty \rightarrow 0^-', ...
       'Origin indentation (-360^\circ CW)', 'Critical point (-1, 0)', 'Location', 'NorthEast');
exportgraphics(gcf, 'figures/fig07_ol_nyquist.pdf');