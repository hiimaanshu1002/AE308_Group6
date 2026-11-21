clear; clc; close all;
group6_params;

K_vals = [1, 5, 20];
t_ends = [200, 60, 25];

figure('Color', 'w', 'Position', [100 100 1050 360]);
for i = 1:3
    subplot(1, 3, i);
    T_p = feedback(K_vals(i) * G, 1);
    t = linspace(0, t_ends(i), 2000);
    [y_imp, t] = impulse(T_p, t);
    
    p_cl = pole(T_p);
    growth_rate = max(real(p_cl));
    
    plot(t, y_imp, 'b-', 'LineWidth', 1.2);
    grid on;
    xlabel('Time t [s]');
    if i == 1, ylabel('\theta_p(t) for Unit Impulse [rad]'); end
    title(sprintf('Group %d: K = %d V/rad (\\sigma = +%.4f s^{-1})', group_num, K_vals(i), growth_rate));
end
sgtitle(sprintf('Group %d: Closed-Loop Impulse Response under Proportional Control (Unstable)', group_num));
exportgraphics(gcf, 'figures/fig03_p_impulse.pdf');