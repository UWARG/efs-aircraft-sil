%% sil_set_matlab_function_code.m - Set code in SIL_Formulas MATLAB Function blocks
%  Run after build_sil_simulink(mdl). Requires model to be open.

function sil_set_matlab_function_code(mdl)
if nargin < 1
    mdl = 'SIL_Formulas';
end
if ~bdIsLoaded(mdl)
    load_system(mdl);
end

% Input u = Mux: Thrust/Torque [rho,D,Omega_p,Va,k1,k2], Lift/Drag [rho,v,S,C_L or C_D], PID [e,e_int,e_der,Kp,Ki,Kd]
code_thrust = [
'function T_p = thrust_block(u)' newline ...
'rho = u(1); D = u(2); Omega_p = u(3); Va = u(4); k1 = u(5); k2 = u(6);' newline ...
'if Omega_p <= 0 || D <= 0' newline ...
'    J = 0; C_T = 0;' newline ...
'else' newline ...
'    J = (2*pi*Va) / (Omega_p*D);' newline ...
'    C_T = k1*J + k2*J^2;' newline ...
'end' newline ...
'T_p = (rho*D^4/(4*pi^2)) * Omega_p^2 * C_T;' newline ...
'end'
];
code_torque = [
'function Q_p = torque_block(u)' newline ...
'rho = u(1); D = u(2); Omega_p = u(3); Va = u(4); k1 = u(5); k2 = u(6);' newline ...
'if Omega_p <= 0 || D <= 0' newline ...
'    J = 0; C_Q = 0;' newline ...
'else' newline ...
'    J = (2*pi*Va) / (Omega_p*D);' newline ...
'    C_Q = k1*J + k2*J^2;' newline ...
'end' newline ...
'Q_p = (rho*D^5/(4*pi^2)) * Omega_p^2 * C_Q;' newline ...
'end'
];

code_lift = [
'function L = lift_block(u)' newline ...
'L = 0.5 * u(1) * u(2)^2 * u(3) * u(4);' newline ...
'end'
];

code_drag = [
'function D = drag_block(u)' newline ...
'D = 0.5 * u(1) * u(2)^2 * u(3) * u(4);' newline ...
'end'
];

code_pid = [
'function y = pid_block(u)' newline ...
'y = u(4)*u(1) + u(5)*u(2) + u(6)*u(3);' newline ...
'end'
];

blks = {
    [mdl '/Thrust_SIL/ThrustFcn'], code_thrust;
    [mdl '/Torque_SIL/TorqueFcn'], code_torque;
    [mdl '/Lift_SIL/LiftFcn'],     code_lift;
    [mdl '/Drag_SIL/DragFcn'],     code_drag;
    [mdl '/PID_Attitude_SIL/PIDFcn'], code_pid
};

for i = 1:size(blks, 1)
    blk = blks{i, 1};
    code = blks{i, 2};
    if ~strcmp(get_param(blk, 'Type'), 'block'), continue; end
    try
        config = get_param(blk, 'MATLABFunctionConfiguration');
        if isprop(config, 'FunctionScript')
            config.FunctionScript = code;
        elseif isprop(config, 'Script')
            config.Script = code;
        end
        set_param(blk, 'MATLABFunctionConfiguration', config);
    catch ME
        warning('Could not set code for %s: %s', blk, ME.message);
    end
end
save_system(mdl);
disp('MATLAB Function block code set. Saved SIL_Formulas.');
end
