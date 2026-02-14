function T = thrust_formula(rho, A, v, C_T)
% THRUST_FORMULA  Propeller thrust per SIL document (sec 1).
%   T = (1/2) * rho * A * v^2 * C_T
%
% Inputs:
%   rho  - Air density (kg/m^3)
%   A    - Effective propeller area (m^2), related to propeller diameter
%   v    - Airspeed or velocity through propeller (m/s)
%   C_T  - Thrust coefficient (use thrust_coefficient() or lookup)
%
% Output:
%   T    - Thrust (N)

T = 0.5 * rho * A * v^2 * C_T;
end
