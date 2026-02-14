function C_T = thrust_coefficient(v, v_tip, k1, k2)
% THRUST_COEFFICIENT  Thrust coefficient per SIL document (sec 2).
%   C_T = k1*(v/v_tip) + k2*(v/v_tip)^2
%
% Inputs:
%   v     - Airspeed or velocity through propeller (m/s)
%   v_tip - Tip speed of propeller (m/s), typically omega * radius
%   k1    - Empirical constant (from experiments or theory)
%   k2    - Empirical constant (from experiments or theory)
%
% Output:
%   C_T   - Thrust coefficient (dimensionless)

if v_tip <= 0
    C_T = 0;
    return
end
ratio = v / v_tip;
C_T = k1 * ratio + k2 * ratio^2;
end
