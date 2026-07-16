classdef GeoConsts
    properties (Constant)
        % ZeroPilot M3
        % S = 0.184;          % Wing area [m^2]
        % b = 5.0;            % Wingspan [m]
        % c = 0.88;           % Mean chord length [m]
        % AR = (b^2)/S;       % Wing aspect ratio
        % D = 0.3;            % Propeller diameter [m]
        % gsf = 1/8.02;       % Geometric scale factor
        % m_full = 740;       % Full-scale aircraft model mass [kg]
        % m_model = 1.70;     % Aircraft model mass [kg]
        % J_fs = [450, 2700, 3000, -120]; % Full-scale inertias: Jx, Jy, Jz, Jxz [slug*ft^2]
        % Not known for ZP:
        % S_prop = 0.2027;    % Area swept out by the propeller [m^2]
        % C_prop = 1.0;       %

        % Constants used for SIL testing:
        S = 0.55;          % Wing area [m^2]
        b = 2.8956;        % Wingspan [m]
        c = 0.18994;       % Mean chord length [m]
        AR = (b^2)/S;      % Wing aspect ratio
        D = 0.3;           % Propeller diameter [m] *** not there?
        gsf = 1;
        m_full = 13.5;     % Full-scale aircraft model mass [kg]
        m_model = m_full;
        J_fs = [0.8244, 1.135, 1.759, 0.1204]; % Full-scale inertias: Jx, Jy, Jz, Jxz [slug*ft^2]
        S_prop = 0.2027;     % Area swept out by the propeller [m^2]
        C_prop = 1.0;        %

        % Misc. Constants
        g = 9.81;           % Gravity [m/s^2]
        rho = 1.2682;       % Air density [kg/m^3]
    end
end
