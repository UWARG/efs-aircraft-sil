classdef LongitudinalCoeffs
    properties (Constant)
        % ZeroPilot M3
        % CL0 = 0.23;
        % CDp = 0.043;
        % CL_q = 7.95;
        % CL_de = 0.13;
        % CD_q = 0.0;
        % CD_de = 0.0135;
        % Cm0 = 0.0135;
        % Cm_alpha = -2.74;
        % Cm_q = -38.21;
        % Cm_de = -0.99;

        % M = 50;

        % Aerosonde UAV Constants for SIL Testing
        CL0 = 0.28;
        CDp = 0.0437;
        CL_q = 0;
        CL_de = -0.36;
        CD_q = 0;
        CD_de = 0;
        Cm0 = -0.02338;
        Cm_alpha = -0.38;
        Cm_q = -3.6;
        Cm_de = -0.5;

        M = 50;

        % Constants for both
        C_prop = 1.0;
    end
end