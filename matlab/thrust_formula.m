function T_p = thrust_formula(rho, D, Omega_p, C_T)
% THRUST_FORMULA  Propeller thrust per propeller theory (screenshot formulas).
%   T_p(Omega_p, C_T) = (rho*D^4 / (4*pi^2)) * Omega_p^2 * C_T
%
%   Thrust and torque vectors are assumed aligned with the motor rotation axis.
%
% Inputs:
%   rho     - Air density (kg/m^3)
%   D       - Propeller diameter (m)
%   Omega_p - Propeller angular velocity (rad/s)
%   C_T     - Thrust coefficient (dimensionless; from lookup vs advance ratio J)
%
% Output:
%   T_p     - Thrust magnitude (N)

T_p = (rho * D^4 / (4 * pi^2)) * Omega_p^2 * C_T;
end
