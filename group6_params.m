%% group6_params.m
% Shared plant parameters, specifications, and controller models for Group 6 (P1)
group_num = 6;
s = tf('s');

% Multipliers & Physical Parameters (Group 6, Table 2 & Section 5.1)
rho1 = 1.20; rho2 = 1.08; rho3 = 1.03;
Jp   = rho1 * 0.0552;    % 0.06624 kg*m^2
Kf   = rho2 * 0.1188;    % 0.128304 N/V
taum = rho3 * 0.050;     % 0.0515 s
L_arm = 0.197;           % m (fixed)

K0      = (Kf * L_arm) / Jp;   % 0.381580 rad/(V*s^2)
p_motor = 1 / taum;            % 19.417476 rad/s
b_gain  = K0 * p_motor;        % 7.409280 rad/(V*s^3)

% Open-Loop Plant Transfer Function G(s)
G = b_gain / (s^2 * (s + p_motor));

% Design Specifications (Table 2 & Reference Test)
Mp_max       = 12.0;           % %
ts_max       = 2.50;           % s (+/- 2% band)
PM_min_table = 44.0;           % deg
GM_min_dB    = 8.0;            % dB
r_deg        = 10.0;           % deg step command
r_rad        = deg2rad(r_deg); % 0.174533 rad

% Translated s-Plane & Frequency Targets (Part B1)
zeta_req   = -log(Mp_max/100) / sqrt(pi^2 + log(Mp_max/100)^2); % 0.5594
beta_deg   = acosd(zeta_req);                                   % 55.99 deg
sigma_req  = 4 / ts_max;                                        % 1.6000 rad/s
wn_req     = sigma_req / zeta_req;                              % 2.8602 rad/s
wd_req     = wn_req * sqrt(1 - zeta_req^2);                     % 2.3707 rad/s
pm_factor  = sqrt(-2*zeta_req^2 + sqrt(1 + 4*zeta_req^4));
PM_target  = atand(2*zeta_req / pm_factor);                     % 56.412 deg
wgc_target = wn_req * pm_factor;                                % 2.1294 rad/s

% Design 1: Ideal Double-PD Controller
K_pd  = 14.325096;
T1_pd = 0.3755298;
T2_pd = 0.3755298;
C_pd  = K_pd * (1 + T1_pd*s) * (1 + T2_pd*s);
L_pd  = C_pd * G;
T_pd  = feedback(L_pd, 1);

% Design 2: Proper Double-Lead Compensator (Selected Design)
K_dl   = 13.47534;
T1_dl  = 0.257635;
T2_dl  = 0.879297;
alpha1 = 0.109122;
alpha2 = 0.198773;
C_dl   = K_dl * ((1 + T1_dl*s)*(1 + T2_dl*s)) / ((1 + alpha1*T1_dl*s)*(1 + alpha2*T2_dl*s));
L_dl   = minreal(C_dl * G);
T_dl   = minreal(feedback(L_dl, 1));
S_dl   = minreal(feedback(1, L_dl));
CS_dl  = minreal(C_dl * S_dl); % Transfer function from R(s) to U(s)

if ~exist('figures', 'dir'), mkdir('figures'); end