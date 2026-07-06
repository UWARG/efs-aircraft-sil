classdef GeoConsts
    properties (Constant)
        S = 0.184;      % Wing area [m^2]
        b = 5.0;        % Wingspan [m]
        c = 0.88;       % Mean chord length [m]
        AR = (b^2)/S;   % Wing aspect ratio
        D = 0.3;        % Propeller diameter [m]
        gsf = 1/8.02;   % Geometric scale factor
        m_model = 1.70; % Aircraft model mass [kg]
        m_full = 740;   % Full-scale aircraft model mass [kg]
        J_fs = [450, 2700, 3000, -120]; % Full-scale inertias: Jx, Jy, Jz, Jxz [slug*ft^2]

        % Misc. Constants
        g = 9.81;       % Gravity [m/s^2]
        rho = 1.225;    % Air density [kg/m^3]
    end
end
