clear; clc; close all;
group6_params;

% Figure 4: Full Root Locus (K > 0 and K < 0)
figure('Color', 'w', 'Position', [100 100 680 460]);
rlocus(G, 'b'); hold on;
rlocus(-G, 'r--');
centroid = -p_motor / 3;
x_asym = linspace(centroid, 6, 100);
plot(x_asym,  sqrt(3)*(x_asym - centroid), 'k:', 'LineWidth', 1.0);
plot(x_asym, -sqrt(3)*(x_asym - centroid), 'k:', 'LineWidth', 1.0);
plot(centroid, 0, 'ko', 'MarkerSize', 7, 'LineWidth', 1.5);
text(centroid, -1.5, sprintf('Centroid = %.4f', centroid), 'HorizontalAlignment', 'center');

grid on; xlim([-26 8]); ylim([-14 14]);
xlabel('Real Axis [rad/s]'); ylabel('Imaginary Axis [rad/s]');
title(sprintf('Group %d: Root Locus of 1 + K G(s) (Proportional Control)', group_num));
legend('K > 0', 'K < 0 (for completeness)', 'Asymptotes', 'Location', 'NorthWest');
exportgraphics(gcf, 'figures/fig04_root_locus.pdf');

% Figure 5: Zoomed Root Locus near Origin (0 < K < 20)
figure('Color', 'w', 'Position', [120 120 650 430]);
K_vec = linspace(0, 22, 1000);
r_mat = rlocus(G, K_vec);
plot(real(r_mat.'), imag(r_mat.'), 'b-', 'LineWidth', 1.8); hold on;

for k_pt = [1, 5, 20]
    p_pt = pole(feedback(k_pt * G, 1));
    plot(real(p_pt), imag(p_pt), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 6);
    [~, idx] = max(imag(p_pt));
    text(real(p_pt(idx)) + 0.008, imag(p_pt(idx)), sprintf('K = %d', k_pt), 'FontSize', 9);
end
xline(0, 'k-', 'LineWidth', 1.1);
grid on; xlim([-0.03 0.25]); ylim([-3.2 3.2]);
xlabel('Real Axis [rad/s]'); ylabel('Imaginary Axis [rad/s]');
title(sprintf('Group %d: Zoomed Root Locus of Dominant Pair (0 < K < 20)', group_num));
exportgraphics(gcf, 'figures/fig05_rl_zoom.pdf');