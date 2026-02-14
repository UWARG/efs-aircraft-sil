function u = pid_attitude(e, e_int, e_der, Kp, Ki, Kd)
% PID_ATTITUDE  PID control for aircraft attitude per SIL document (sec 4).
%   u(t) = Kp*e(t) + Ki*integral(e) + Kd*de/dt
%
% Inputs:
%   e     - Error (desired - actual attitude, e.g. roll/pitch/yaw angle), rad or deg
%   e_int - Integral of error (accumulated over time)
%   e_der - Derivative of error (rate of change of error)
%   Kp    - Proportional gain
%   Ki    - Integral gain
%   Kd    - Derivative gain
%
% Output:
%   u     - Control output (e.g. control surface command)
%
% Usage: Call each timestep; integrate e and differentiate e externally
%        or use a stateful wrapper for discrete-time simulation.

u = Kp * e + Ki * e_int + Kd * e_der;
end
