# Propulsion Subsystem Model
Everything in here is referenced from "Small Unmanned Aircraft: Theory and Practice" by Beard and McLain.

## Variables
#### Variable Inputs:

| Input Symbol | Description |
|-------|---------|
| **pwm_cmd** | Pulse-width modulation command for throttle |
| **Va** | Airspeed (m/s) |

#### Constants:
| Input Symbol | Description |
|-------|---------|
| **rho, $\rho$** | Air density (kg/m³) |
| **S_prop** | Area swept out by the propeller (m^2) |
| **C_prop** | Propeller aerodynamic coeff. Efficiency factor to scale theoretical thrust to model actual thrust provided. |
| **k_motor** | Motor constant for exit velocity. Linear relationship between PWM throttle cmd and V_exit from propeller. |  
| **k_Tp** | Propeller torque const. Relates square of the propeller's speed to T_p |
| **k_omega, $k_{\Omega}$** | Motor constant for angular velocity. Relates PWM cmd and actual rotational speed of propeller (omega). |

The last 3 constants are experimentally determined.

#### Outputs:

| Output | Connect to |
|--------|------------|
| **T_p** (thrust) | **Total External Forces** **Fx** (body forward) |
| **Q_p** (torque) | **Total External Moments** on the relevant axis (e.g. single propeller about spin axis) |

## Propeller Thrust Calculation
Apply Bernoulli's principle to calculate the pressure ahead and behind a propeller.

$$ P_{upstream} = P_0 + \frac{1}{2}\rho V_a^2 $$
$$ P_{downstream} = P_0 + \frac{1}{2}\rho V_{exit}^2 $$
Where $P_0$ is the static pressure, $V_{exit}$ is the speed of the air as it leaves the propeller. It can also be described as:

$$ V_{exit} = k_{motor} \delta_{t} $$
Where $\delta_{t}$ here is actually pwm_cmd as specified in the variable tables.

Then, we apply the pressure difference to the propeller area. The thrust produced by the motor is:
$$ F_{x_{p}} = S_{prop}C_{prop}(P_{downstream} - P_{upstream}) $$
$$ = \frac{1}{2} \rho S_{prop} C_{prop} ((k_{motor}\delta_t)^2 - V_a^2) $$

Hence,
$$ f_p = \frac{1}{2} \rho S_{prop} C_{prop} * \begin{pmatrix} ((k_{motor}\delta_t)^2 - V_a^2) \\ 0 \\ 0 \end{pmatrix} $$

## Propeller Torque Calculation
The torque applied by the motor to the propeller (and then to the air) results in an equal and opposite torque applied by the propeller to the motor. This is fixed to the MAV body.
This torque is opposite to the direction of propeller rotation, and proportional to the square of the propeller angular velocity, $\Omega = k_{\Omega} \delta_t $:
$$ T_p = -k_{T_{p}} (k_{\Omega} \delta_t)^2 $$

Therefore, moments produced by the propulsion system are just:
$$ m_p = \begin{pmatrix} -k_{T_{p}} (k_{\Omega} \delta_t)^2 \\ 0 \\ 0 \end{pmatrix} $$