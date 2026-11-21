%% run_all_figures.m
% Master script for AE 308/775 Final Report - Group 6 (Problem P1)
% Runs each script in an isolated function scope so 'clear' inside individual
% scripts never wipes out loop variables, and exports all 13 figures as 300 DPI PNGs.

script_dir = fileparts(mfilename('fullpath'));
if ~isempty(script_dir)
    cd(script_dir);
end
if ~exist('figures', 'dir')
    mkdir('figures');
end

fprintf('=== Generating all 13 PNG figures for Group 6 (Problem P1) ===\n');

scripts = {
    'fig01_open_loop_pzmap', ...
    'fig02_open_loop_step', ...
    'fig03_proportional_impulse', ...
    'fig04_05_root_locus', ...
    'fig06_open_loop_bode', ...
    'fig07_open_loop_nyquist', ...
    'fig08_admissible_region', ...
    'fig09_design_construction_bode', ...
    'fig10_candidate_comparison', ...
    'fig11_compensated_bode', ...
    'fig12_compensated_nyquist', ...
    'fig13_closed_loop_pzmap'
};

png_names = {
    'fig01_pzmap.png', ...
    'fig02_ol_step.png', ...
    'fig03_p_impulse.png', ...
    'fig04_root_locus.png', ...
    'fig05_rl_zoom.png', ...
    'fig06_ol_bode.png', ...
    'fig07_ol_nyquist.png', ...
    'fig08_admissible_region.png', ...
    'fig09_design_construction.png', ...
    'fig10_candidate_comparison.png', ...
    'fig11_compensated_bode.png', ...
    'fig12_compensated_nyquist.png', ...
    'fig13_cl_pzmap.png'
};

fig_counter = 1;
for k = 1:length(scripts)
    close all;
    run_isolated_script([scripts{k} '.m']);
    
    figs = flipud(findobj('Type', 'figure'));
    for f = 1:length(figs)
        out_path = fullfile('figures', png_names{fig_counter});
        exportgraphics(figs(f), out_path, 'Resolution', 300);
        fprintf('Saved: %s\n', out_path);
        fig_counter = fig_counter + 1;
    end
end
close all;

% Print final numerical verification summary
group6_params;
info_dl = stepinfo(T_dl, 'SettlingTimeThreshold', 0.02);
[Gm_dl, Pm_dl, Wcg_dl, Wcp_dl] = margin(L_dl);
t_sim = linspace(0, 6, 60001);
[u_sim, t_sim] = step(r_rad * CS_dl, t_sim);

fprintf('\n=== Group %d Double-Lead Verification Summary ===\n', group_num);
fprintf('Overshoot Mp:       %.4f %% (Spec <= 12.0%%)\n', info_dl.Overshoot);
fprintf('Rise Time tr:       %.4f s\n', info_dl.RiseTime);
fprintf('Settling Time ts:   %.4f s (Spec <= 2.50 s)\n', info_dl.SettlingTime);
fprintf('Gain Crossover wgc: %.4f rad/s\n', Wcp_dl);
fprintf('Phase Margin PM:    %.4f deg (Binding >= %.3f deg)\n', Pm_dl, PM_target);
fprintf('Gain Margin GM:     %.4f (%.4f dB, Spec >= 8 dB)\n', Gm_dl, 20*log10(Gm_dl));
fprintf('Peak Effort u_max:  %.4f V at t = 0+ s\n', max(abs(u_sim)));
fprintf('Control Energy:     %.4f V^2*s\n', trapz(t_sim, u_sim.^2));

function run_isolated_script(script_file)
    % Isolates 'clear' inside each figure script from the caller's workspace
    run(script_file);
end