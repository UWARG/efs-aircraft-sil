function L = lift_formula(rho, v, S, C_L)
% LIFT_FORMULA  Lift force per SIL document (sec 3).
%   L = (1/2) * rho * v^2 * S * C_L
%
% Inputs:
%   rho  - Air density (kg/m^3)
%   v    - Airspeed (m/s)
%   S    - Wing area (m^2)
%   C_L  - Lift coefficient (depends on angle of attack, flight conditions)
%
% Output:
%   L    - Lift force (N)

L = 0.5 * rho * v^2 * S * C_L;
end
