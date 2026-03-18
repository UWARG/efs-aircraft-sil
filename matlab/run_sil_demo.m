%% run_sil_demo.m - SIL formulas demo (propeller theory from screenshot formulas)
%  Uses: J = 2*pi*Va/(Omega_p*D), T_p = (rho*D^4/(4*pi^2))*Omega_p^2*C_T,
%        Q_p = (rho*D^5/(4*pi^2))*Omega_p^2*C_Q. C_T, C_Q from J (demo: polynomial).
%  Add matlab folder to path: addpath('matlab') or run from project root.

addpath(fileparts(mfilename('fullpath')));

%% 1. Propeller thrust and torque (screenshot formulas)
rho    = 1.225;   % kg/m^3 (sea level)
D      = 0.3;     % m propeller diameter
Omega_p = 200*2*pi/60;  % rad/s (200 RPM)
V_a    = 15;      % m/s airspeed
k1     = 0.1;     % C_T = k1*J + k2*J^2 (example)
k2     = 0.02;
k1q    = 0.01;    % C_Q = k1q*J + k2q*J^2 (example)
k2q    = 0.005;

J   = advanced_ratio(Omega_p, V_a, D);
C_T = thrust_coefficient_from_J(J, k1, k2);
C_Q = torque_coefficient_from_J(J, k1q, k2q);
T_p = thrust_formula(rho, D, Omega_p, C_T);
Q_p = torque_formula(rho, D, Omega_p, C_Q);

fprintf('1. Propeller (screenshot formulas):\n');
fprintf('   J = %.4f, C_T = %.4f, C_Q = %.4f\n', J, C_T, C_Q);
fprintf('   T_p = %.2f N, Q_p = %.4f N·m\n', T_p, Q_p);

%% 2. Aerodynamic forces (Lift, Drag)
S   = 0.5;   % m^2 wing area
C_L = 0.8;   % lift coefficient (depends on alpha, etc.)
C_D = 0.05;  % drag coefficient

L = lift_formula(rho, V_a, S, C_L);
D = drag_formula(rho, V_a, S, C_D);
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

%% Optional: sweep airspeed for thrust and torque
v_vec = linspace(5, 25, 50);
T_vec = zeros(size(v_vec));
Q_vec = zeros(size(v_vec));
for i = 1:numel(v_vec)
    J_i   = advanced_ratio(Omega_p, v_vec(i), D);
    CT_i  = thrust_coefficient_from_J(J_i, k1, k2);
    CQ_i  = torque_coefficient_from_J(J_i, k1q, k2q);
    T_vec(i) = thrust_formula(rho, D, Omega_p, CT_i);
    Q_vec(i) = torque_formula(rho, D, Omega_p, CQ_i);
end
figure('Name', 'SIL Demo');
subplot(2,1,1);
plot(v_vec, T_vec, 'b-');
xlabel('Airspeed (m/s)'); ylabel('Thrust T_p (N)');
title('Thrust vs airspeed (T_p = \rho D^4/(4\pi^2) \Omega_p^2 C_T)');
grid on;
subplot(2,1,2);
plot(v_vec, Q_vec, 'b-');
xlabel('Airspeed (m/s)'); ylabel('Torque Q_p (N·m)');
title('Torque vs airspeed (Q_p = \rho D^5/(4\pi^2) \Omega_p^2 C_Q)');
grid on;

figure('Name', 'SIL Demo - Lift & Drag');
plot(v_vec, lift_formula(rho, v_vec, S, C_L), 'b-'); hold on;
plot(v_vec, drag_formula(rho, v_vec, S, C_D), 'r-');
xlabel('Airspeed (m/s)'); ylabel('Force (N)');
legend('Lift', 'Drag');
title('Lift & Drag vs airspeed');
grid on; hold off;
