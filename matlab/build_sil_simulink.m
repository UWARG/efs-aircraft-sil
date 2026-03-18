%% build_sil_simulink.m - Build SIL formulas in Simulink (from sil.docx)
%  Run in MATLAB to create model SIL_Formulas.slx with Thrust, Aero, PID blocks.
%  Then copy the subsystems into AM_SITL.slx or use Model Reference.

mdl = 'SIL_Formulas';
if bdIsLoaded(mdl)
    close_system(mdl, 0);
end
if exist([mdl '.slx'], 'file')
    delete([mdl '.slx']);
end

new_system(mdl);
open_system(mdl);

%% Positions
x0 = 50;  dx = 180;  y0 = 80;  dy = 50;

%% --- Thrust subsystem (screenshot: T_p = (rho*D^4/(4*pi^2))*Omega_p^2*C_T, J = 2*pi*Va/(Omega_p*D)) ---
add_block('simulink/Ports & Subsystems/Subsystem', [mdl '/Thrust_SIL']);
open_system([mdl '/Thrust_SIL']);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Thrust_SIL/rho'], 'Position', [20 40 50 55]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Thrust_SIL/D'], 'Position', [20 90 50 105]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Thrust_SIL/Omega_p'], 'Position', [20 140 50 155]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Thrust_SIL/Va'], 'Position', [20 190 50 205]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Thrust_SIL/k1'], 'Position', [20 240 50 255]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Thrust_SIL/k2'], 'Position', [20 290 50 305]);
add_block('simulink/Signal Routing/Mux', [mdl '/Thrust_SIL/Mux'], 'Position', [80 150 100 230], 'Inputs', '6');
add_block('simulink/User-Defined Functions/MATLAB Function', [mdl '/Thrust_SIL/ThrustFcn'], 'Position', [140 160 240 220]);
add_block('simulink/Ports & Subsystems/Out1', [mdl '/Thrust_SIL/T_p'], 'Position', [280 185 310 200]);
add_line([mdl '/Thrust_SIL'], 'rho/1', 'Mux/1');
add_line([mdl '/Thrust_SIL'], 'D/1', 'Mux/2');
add_line([mdl '/Thrust_SIL'], 'Omega_p/1', 'Mux/3');
add_line([mdl '/Thrust_SIL'], 'Va/1', 'Mux/4');
add_line([mdl '/Thrust_SIL'], 'k1/1', 'Mux/5');
add_line([mdl '/Thrust_SIL'], 'k2/1', 'Mux/6');
add_line([mdl '/Thrust_SIL'], 'Mux/1', 'ThrustFcn/1');
add_line([mdl '/Thrust_SIL'], 'ThrustFcn/1', 'T_p/1');
close_system([mdl '/Thrust_SIL']);
set_param([mdl '/Thrust_SIL'], 'Position', [x0 y0 x0+160 y0+320]);

%% --- Torque subsystem (screenshot: Q_p = (rho*D^5/(4*pi^2))*Omega_p^2*C_Q) ---
add_block('simulink/Ports & Subsystems/Subsystem', [mdl '/Torque_SIL']);
open_system([mdl '/Torque_SIL']);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Torque_SIL/rho'], 'Position', [20 40 50 55]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Torque_SIL/D'], 'Position', [20 90 50 105]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Torque_SIL/Omega_p'], 'Position', [20 140 50 155]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Torque_SIL/Va'], 'Position', [20 190 50 205]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Torque_SIL/k1'], 'Position', [20 240 50 255]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Torque_SIL/k2'], 'Position', [20 290 50 305]);
add_block('simulink/Signal Routing/Mux', [mdl '/Torque_SIL/Mux'], 'Position', [80 150 100 230], 'Inputs', '6');
add_block('simulink/User-Defined Functions/MATLAB Function', [mdl '/Torque_SIL/TorqueFcn'], 'Position', [140 160 240 220]);
add_block('simulink/Ports & Subsystems/Out1', [mdl '/Torque_SIL/Q_p'], 'Position', [280 185 310 200]);
add_line([mdl '/Torque_SIL'], 'rho/1', 'Mux/1');
add_line([mdl '/Torque_SIL'], 'D/1', 'Mux/2');
add_line([mdl '/Torque_SIL'], 'Omega_p/1', 'Mux/3');
add_line([mdl '/Torque_SIL'], 'Va/1', 'Mux/4');
add_line([mdl '/Torque_SIL'], 'k1/1', 'Mux/5');
add_line([mdl '/Torque_SIL'], 'k2/1', 'Mux/6');
add_line([mdl '/Torque_SIL'], 'Mux/1', 'TorqueFcn/1');
add_line([mdl '/Torque_SIL'], 'TorqueFcn/1', 'Q_p/1');
close_system([mdl '/Torque_SIL']);
set_param([mdl '/Torque_SIL'], 'Position', [x0+dx y0 x0+dx+160 y0+320]);

%% --- Lift subsystem L = 0.5*rho*v^2*S*C_L ---
add_block('simulink/Ports & Subsystems/Subsystem', [mdl '/Lift_SIL']);
open_system([mdl '/Lift_SIL']);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Lift_SIL/rho'], 'Position', [20 40 50 55]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Lift_SIL/v'], 'Position', [20 90 50 105]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Lift_SIL/S'], 'Position', [20 140 50 155]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Lift_SIL/C_L'], 'Position', [20 190 50 205]);
add_block('simulink/Signal Routing/Mux', [mdl '/Lift_SIL/Mux'], 'Position', [80 100 100 160], 'Inputs', '4');
add_block('simulink/User-Defined Functions/MATLAB Function', [mdl '/Lift_SIL/LiftFcn'], 'Position', [140 110 240 170]);
add_block('simulink/Ports & Subsystems/Out1', [mdl '/Lift_SIL/L'], 'Position', [280 135 310 150]);
add_line([mdl '/Lift_SIL'], 'rho/1', 'Mux/1');
add_line([mdl '/Lift_SIL'], 'v/1', 'Mux/2');
add_line([mdl '/Lift_SIL'], 'S/1', 'Mux/3');
add_line([mdl '/Lift_SIL'], 'C_L/1', 'Mux/4');
add_line([mdl '/Lift_SIL'], 'Mux/1', 'LiftFcn/1');
add_line([mdl '/Lift_SIL'], 'LiftFcn/1', 'L/1');
close_system([mdl '/Lift_SIL']);
set_param([mdl '/Lift_SIL'], 'Position', [x0+2*dx y0 x0+2*dx+160 y0+220]);

%% --- Drag subsystem D = 0.5*rho*v^2*S*C_D ---
add_block('simulink/Ports & Subsystems/Subsystem', [mdl '/Drag_SIL']);
open_system([mdl '/Drag_SIL']);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Drag_SIL/rho'], 'Position', [20 40 50 55]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Drag_SIL/v'], 'Position', [20 90 50 105]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Drag_SIL/S'], 'Position', [20 140 50 155]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/Drag_SIL/C_D'], 'Position', [20 190 50 205]);
add_block('simulink/Signal Routing/Mux', [mdl '/Drag_SIL/Mux'], 'Position', [80 100 100 160], 'Inputs', '4');
add_block('simulink/User-Defined Functions/MATLAB Function', [mdl '/Drag_SIL/DragFcn'], 'Position', [140 110 240 170]);
add_block('simulink/Ports & Subsystems/Out1', [mdl '/Drag_SIL/D'], 'Position', [280 135 310 150]);
add_line([mdl '/Drag_SIL'], 'rho/1', 'Mux/1');
add_line([mdl '/Drag_SIL'], 'v/1', 'Mux/2');
add_line([mdl '/Drag_SIL'], 'S/1', 'Mux/3');
add_line([mdl '/Drag_SIL'], 'C_D/1', 'Mux/4');
add_line([mdl '/Drag_SIL'], 'Mux/1', 'DragFcn/1');
add_line([mdl '/Drag_SIL'], 'DragFcn/1', 'D/1');
close_system([mdl '/Drag_SIL']);
set_param([mdl '/Drag_SIL'], 'Position', [x0+3*dx y0 x0+3*dx+160 y0+220]);

%% --- PID attitude u = Kp*e + Ki*e_int + Kd*e_der ---
add_block('simulink/Ports & Subsystems/Subsystem', [mdl '/PID_Attitude_SIL']);
open_system([mdl '/PID_Attitude_SIL']);
add_block('simulink/Ports & Subsystems/In1', [mdl '/PID_Attitude_SIL/e'], 'Position', [20 40 50 55]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/PID_Attitude_SIL/e_int'], 'Position', [20 90 50 105]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/PID_Attitude_SIL/e_der'], 'Position', [20 140 50 155]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/PID_Attitude_SIL/Kp'], 'Position', [20 190 50 205]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/PID_Attitude_SIL/Ki'], 'Position', [20 240 50 255]);
add_block('simulink/Ports & Subsystems/In1', [mdl '/PID_Attitude_SIL/Kd'], 'Position', [20 290 50 305]);
add_block('simulink/Signal Routing/Mux', [mdl '/PID_Attitude_SIL/Mux'], 'Position', [80 150 100 230], 'Inputs', '6');
add_block('simulink/User-Defined Functions/MATLAB Function', [mdl '/PID_Attitude_SIL/PIDFcn'], 'Position', [140 170 240 210]);
add_block('simulink/Ports & Subsystems/Out1', [mdl '/PID_Attitude_SIL/u'], 'Position', [280 188 310 203]);
add_line([mdl '/PID_Attitude_SIL'], 'e/1', 'Mux/1');
add_line([mdl '/PID_Attitude_SIL'], 'e_int/1', 'Mux/2');
add_line([mdl '/PID_Attitude_SIL'], 'e_der/1', 'Mux/3');
add_line([mdl '/PID_Attitude_SIL'], 'Kp/1', 'Mux/4');
add_line([mdl '/PID_Attitude_SIL'], 'Ki/1', 'Mux/5');
add_line([mdl '/PID_Attitude_SIL'], 'Kd/1', 'Mux/6');
add_line([mdl '/PID_Attitude_SIL'], 'Mux/1', 'PIDFcn/1');
add_line([mdl '/PID_Attitude_SIL'], 'PIDFcn/1', 'u/1');
close_system([mdl '/PID_Attitude_SIL']);
set_param([mdl '/PID_Attitude_SIL'], 'Position', [x0+4*dx y0 x0+4*dx+160 y0+320]);

%% Save
save_system(mdl);

%% Optionally fill MATLAB Function block code (edit block code in Simulink if this fails)
try
    sil_set_matlab_function_code(mdl);
catch
    fprintf('Paste code into each MATLAB Function block from: matlab/SIL_Simulink_Block_Code.m\n');
end

fprintf('Created %s.slx with Thrust_SIL, Torque_SIL, Lift_SIL, Drag_SIL, PID_Attitude_SIL.\n', mdl);
fprintf('Copy these subsystems into AM_SITL.slx or use as Model Reference.\n');
