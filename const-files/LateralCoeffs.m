classdef LateralCoeffs
    properties (Constant)
        % ZeroPilot M3
        % CY0 = 0.0;
        % CY_beta = -0.83;
        % CY_p = 0.0;
        % CY_r = 0.0;
        % CY_da = 0.17;
        % CY_dr = 0.19;
        % 
        % Cl0 = 0.0;
        % Cl_beta = -0.13;
        % Cl_p = -0.51;
        % Cl_r = 0.25;
        % Cl_da = 0.17;
        % Cl_dr = 0.0024;
        % 
        % Cn0 = 0.0;
        % Cn_beta = 0.073;
        % Cn_p = -0.069;
        % Cn_r = -0.095;
        % Cn_da = -0.011;
        % Cn_dr = -0.069;
        %
        % k_motor = 80;


        % Aerosonde UAV Constants for SIL Testing
        CY0 = 0.0;
        CY_beta = -0.98;
        CY_p = 0.0;
        CY_r = 0.0;
        CY_da = 0;
        CY_dr = -0.17;

        Cl0 = 0.0;
        Cl_beta = -0.12;
        Cl_p = -0.26;
        Cl_r = 0.14;
        Cl_da = 0.08;
        Cl_dr = 0.105;

        Cn0 = 0.0;
        Cn_beta = 0.25;
        Cn_p = 0.022;
        Cn_r = -0.35;
        Cn_da = 0.06;
        Cn_dr = -0.032;

        k_motor = 80;

        % Constants for both
        k_Tp = 0;          % constant determined experimentally for Propulsion Torque
        k_omega = 0;       % constant determined experimentally for Propulsion Torque
    end
end
