%% run_sil_demo.m - SIL formulas demo (from sil.docx)
%  Demonstrates thrust, thrust coefficient, lift, drag, and PID per SIL doc.
%  Add matlab folder to path: addpath('matlab') or run from project root.

addpath(fileparts(mfilename('fullpath')));

%% 1. Thrust coefficient and thrust
rho   = 1.225;   % kg/m^3 (sea level)
A     = 0.1;     % m^2 effective propeller area
v     = 15;      % m/s airspeed
omega = 200*2*pi/60;  % rad/s (200 RPM)
R     = 0.15;    % m propeller radius
v_tip = omega * R;
k1    = 0.5;     % example empirical constants
k2    = 0.1;

C_T = thrust_coefficient(v, v_tip, k1, k2);
T   = thrust_formula(rho, A, v, C_T);
fprintf('1. Thrust: C_T = %.4f, T = %.2f N\n', C_T, T);

%% 2. Aerodynamic forces (Lift, Drag)
S   = 0.5;   % m^2 wing area
C_L = 0.8;   % lift coefficient (depends on alpha, etc.)
C_D = 0.05;  % drag coefficient

L = lift_formula(rho, v, S, C_L);
D = drag_formula(rho, v, S, C_D);
fprintf('2. Aerodynamics: L = %.2f N, D = %.2f N\n', L, D);

%% 3. PID attitude control (example one axis)
Kp = 1.0;
Ki = 0.2;
Kd = 0.1;
e     = 0.1;    % rad error (e.g. desired - actual roll)
e_int = 0.05;   % integrated error
e_der = -0.02;  % derivative of error

u = pid_attitude(e, e_int, e_der, Kp, Ki, Kd);
fprintf('3. PID output: u = %.4f\n', u);

%% Optional: sweep airspeed for thrust
v_vec = linspace(5, 25, 50);
T_vec = zeros(size(v_vec));
for i = 1:numel(v_vec)
    CT = thrust_coefficient(v_vec(i), v_tip, k1, k2);
    T_vec(i) = thrust_formula(rho, A, v_vec(i), CT);
end
figure('Name', 'SIL Demo');
subplot(2,1,1);
plot(v_vec, T_vec, 'b-');
xlabel('Airspeed (m/s)'); ylabel('Thrust (N)');
title('Thrust vs airspeed (SIL formula)');
grid on;
subplot(2,1,2);
plot(v_vec, lift_formula(rho, v_vec, S, C_L), 'b-'); hold on;
plot(v_vec, drag_formula(rho, v_vec, S, C_D), 'r-');
xlabel('Airspeed (m/s)'); ylabel('Force (N)');
legend('Lift', 'Drag');
title('Lift & Drag vs airspeed');
grid on; hold off;
