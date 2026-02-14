function D = drag_formula(rho, v, S, C_D)
% DRAG_FORMULA  Drag force per SIL document (sec 3).
%   D = (1/2) * rho * v^2 * S * C_D
%
% Inputs:
%   rho  - Air density (kg/m^3)
%   v    - Airspeed (m/s)
%   S    - Wing area (m^2)
%   C_D  - Drag coefficient (depends on speed, angle of attack, etc.)
%
% Output:
%   D    - Drag force (N)

D = 0.5 * rho * v^2 * S * C_D;
end
