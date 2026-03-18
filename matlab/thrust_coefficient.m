function C_T = thrust_coefficient(v, v_tip, k1, k2)
% THRUST_COEFFICIENT  Thrust coefficient from velocity ratio (converted to J).
%   Uses J = pi*(v/v_tip) so C_T = k1*J + k2*J^2.
%   Prefer: J = advanced_ratio(Omega_p, V_a, D); C_T = thrust_coefficient_from_J(J, k1, k2).
%
% Inputs:
%   v     - Airspeed (m/s)
%   v_tip - Tip speed omega*R (m/s)
%   k1, k2 - Empirical constants
%
% Output:
%   C_T   - Thrust coefficient (dimensionless)

if v_tip <= 0
    C_T = 0;
    return
end
J = pi * (v / v_tip);  % J = 2*pi*Va/(Omega_p*D), v_tip = Omega_p*D/2 => J = pi*v/v_tip
C_T = thrust_coefficient_from_J(J, k1, k2);
end
