%% SIL_Simulink_Block_Code.m
%  Copy each function below into the corresponding MATLAB Function block
%  in SIL_Formulas.slx (after running build_sil_simulink.m).
%
%  Propeller formulas (screenshot): J = 2*pi*Va/(Omega_p*D),
%  T_p = (rho*D^4/(4*pi^2))*Omega_p^2*C_T, Q_p = (rho*D^5/(4*pi^2))*Omega_p^2*C_Q.
%
%  - Thrust_SIL/ThrustFcn  -> paste thrust_block()
%  - Torque_SIL/TorqueFcn -> paste torque_block()  [if Torque_SIL exists]
%  - Lift_SIL/LiftFcn      -> paste lift_block()
%  - Drag_SIL/DragFcn      -> paste drag_block()
%  - PID_Attitude_SIL/PIDFcn -> paste pid_block()

%% ========== Paste into Thrust_SIL/ThrustFcn (input = Mux of [rho,D,Omega_p,Va,k1,k2]) ==========
function T_p = thrust_block(u)
% u(1)=rho, u(2)=D, u(3)=Omega_p, u(4)=Va, u(5)=k1, u(6)=k2
rho = u(1); D = u(2); Omega_p = u(3); Va = u(4); k1 = u(5); k2 = u(6);
if Omega_p <= 0 || D <= 0
    J = 0;
    C_T = 0;
else
    J = (2*pi*Va) / (Omega_p*D);
    C_T = k1*J + k2*J^2;
end
T_p = (rho*D^4/(4*pi^2)) * Omega_p^2 * C_T;
end

%% ========== Paste into Torque_SIL/TorqueFcn (input = Mux of [rho,D,Omega_p,Va,k1,k2]) ==========
function Q_p = torque_block(u)
% u(1)=rho, u(2)=D, u(3)=Omega_p, u(4)=Va, u(5)=k1, u(6)=k2 (C_Q = k1*J + k2*J^2)
rho = u(1); D = u(2); Omega_p = u(3); Va = u(4); k1 = u(5); k2 = u(6);
if Omega_p <= 0 || D <= 0
    J = 0;
    C_Q = 0;
else
    J = (2*pi*Va) / (Omega_p*D);
    C_Q = k1*J + k2*J^2;
end
Q_p = (rho*D^5/(4*pi^2)) * Omega_p^2 * C_Q;
end

%% ========== Paste into Lift_SIL/LiftFcn (input = Mux of [rho,v,S,C_L]) ==========
function L = lift_block(u)
% u(1)=rho, u(2)=v, u(3)=S, u(4)=C_L
L = 0.5 * u(1) * u(2)^2 * u(3) * u(4);
end

%% ========== Paste into Drag_SIL/DragFcn (input = Mux of [rho,v,S,C_D]) ==========
function D = drag_block(u)
% u(1)=rho, u(2)=v, u(3)=S, u(4)=C_D
D = 0.5 * u(1) * u(2)^2 * u(3) * u(4);
end

%% ========== Paste into PID_Attitude_SIL/PIDFcn (input = Mux of [e,e_int,e_der,Kp,Ki,Kd]) ==========
function y = pid_block(u)
% u(1)=e, u(2)=e_int, u(3)=e_der, u(4)=Kp, u(5)=Ki, u(6)=Kd
y = u(4)*u(1) + u(5)*u(2) + u(6)*u(3);
end
