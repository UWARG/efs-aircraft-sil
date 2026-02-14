%% SIL_Simulink_Block_Code.m
%  Copy each function below into the corresponding MATLAB Function block
%  in SIL_Formulas.slx (after running build_sil_simulink.m).
%
%  - Thrust_SIL/ThrustFcn  -> paste thrust_block()
%  - Lift_SIL/LiftFcn      -> paste lift_block()
%  - Drag_SIL/DragFcn      -> paste drag_block()
%  - PID_Attitude_SIL/PIDFcn -> paste pid_block()

%% ========== Paste into Thrust_SIL/ThrustFcn (input = Mux of [rho,A,v,v_tip,k1,k2]) ==========
function T = thrust_block(u)
% u(1)=rho, u(2)=A, u(3)=v, u(4)=v_tip, u(5)=k1, u(6)=k2
rho = u(1); A = u(2); v = u(3); v_tip = u(4); k1 = u(5); k2 = u(6);
if v_tip <= 0
    C_T = 0;
else
    ratio = v / v_tip;
    C_T = k1 * ratio + k2 * ratio^2;
end
T = 0.5 * rho * A * v^2 * C_T;
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
