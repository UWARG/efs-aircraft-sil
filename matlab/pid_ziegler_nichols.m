function [Kp, Ki, Kd] = pid_ziegler_nichols(Ku, Tu, type)
% PID_ZIEGLER_NICHOLS  Initial PID gains per Ziegler-Nichols (SIL doc sec 4).
%   Use after increasing Kp until sustained oscillation; measure period Tu.
%
% Inputs:
%   Ku   - Ultimate gain (Kp at which system oscillates steadily)
%   Tu   - Ultimate period (oscillation period in same time units as dt)
%   type - 'classic' (original Z-N) or 'pid' (for PID controller)
%
% Outputs:
%   Kp, Ki, Kd - Suggested gains
%
% Classic Z-N for PID: Kp=0.6*Ku, Ki=2*Kp/Tu, Kd=Kp*Tu/8

if nargin < 3
    type = 'pid';
end

switch lower(type)
    case 'classic'
        % Original Ziegler-Nichols PID
        Kp = 0.6 * Ku;
        Ki = 2 * Kp / Tu;
        Kd = Kp * Tu / 8;
    case 'pid'
        Kp = 0.6 * Ku;
        Ki = 2 * Kp / Tu;
        Kd = Kp * Tu / 8;
    otherwise
        Kp = 0.6 * Ku;
        Ki = 2 * Kp / Tu;
        Kd = Kp * Tu / 8;
end
end
