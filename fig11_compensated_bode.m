clear; clc; close all;
group6_params;

[Gm, Pm, Wcg, Wcp] = margin(L_dl);

figure('Color', 'w', 'Position', [100 100 720 500]);
margin(L_dl);
grid on;
title(sprintf('Group %d: Compensated Open-Loop Bode Plot L(s) = C_{DL}(s)G(s) (PM = %.2f^\\circ, GM = %.2f dB)', ...
      group_num, Pm, 20*log10(Gm)));
exportgraphics(gcf, 'figures/fig11_compensated_bode.pdf');