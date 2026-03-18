# efs-aircraft-sil
Creating a simulink model of the ZP aircraft.

## MATLAB (from sil.docx)

Formulas from the SIL document are implemented in the `matlab/` folder:

| File | Description |
|------|-------------|
| `advanced_ratio.m` | Advance ratio J = 2πV_a/(Ω_p·D) |
| `thrust_formula.m` | Thrust T_p = (ρD⁴/(4π²))·Ω_p²·C_T |
| `torque_formula.m` | Torque Q_p = (ρD⁵/(4π²))·Ω_p²·C_Q |
| `thrust_coefficient_from_J.m` | C_T from J (e.g. k₁J + k₂J²) |
| `torque_coefficient_from_J.m` | C_Q from J (e.g. k₁J + k₂J²) |
| `thrust_coefficient.m` | C_T from v/v_tip (uses J internally) |
| `lift_formula.m` | Lift L = (1/2)ρv²S·C_L |
| `drag_formula.m` | Drag D = (1/2)ρv²S·C_D |
| `pid_attitude.m` | PID: u = Kp·e + Ki·∫e + Kd·de/dt |
| `pid_ziegler_nichols.m` | Ziegler–Nichols initial gains from Ku, Tu |
| `run_sil_demo.m` | Demo script (thrust, aero, PID + plots) |
| `build_sil_simulink.m` | Creates SIL_Formulas.slx with Thrust/Torque/Lift/Drag/PID subsystems |
| `sil_set_matlab_function_code.m` | Fills MATLAB Function block code in SIL_Formulas |
| `SIL_Simulink_Block_Code.m` | Code to paste into each MATLAB Function block (if needed) |


### Wiring reference

**Thrust_SIL / Torque_SIL inputs:**

| Input | Meaning | Suggested source |
|-------|---------|------------------|
| **rho** | Air density (kg/m³) | **Constant**, e.g. 1.225 |
| **D** | Propeller diameter (m) | **Constant**, e.g. 0.3 |
| **Omega_p** | Propeller angular velocity (rad/s) | Motor/ESC or throttle model, or **Constant** for testing |
| **Va** | Airspeed (m/s) | From Rigid Body velocities: **sqrt(u²+v²+w²)**, or **Constant** for testing |
| **k1, k2** | C_T / C_Q coefficients | **Constant** (e.g. 0.1, 0.02) |

**Where the formula outputs go:**

| Output | Connect to | Notes |
|--------|------------|-------|
| **T_p** (thrust) | **Total External Forces** **Fx** (body forward) | Combine with L, D via **Sum** / **Gain** into `[Fx, Fy, Fz]`, then **Mux** to the "Total External Forces" input |
| **Q_p** (torque) | **Total External Moments** on the relevant axis (e.g. single propeller about spin axis) | For multiple propellers, sum/difference Q_p by rotation direction into roll/pitch/yaw; omit if not modelling moments yet |

**Minimal wiring (thrust only):**

1. Copy **Thrust_SIL** into AM_SITL.
2. Feed all six inputs with **Constant** blocks: rho=1.225, D=0.3, Omega_p=20, Va=15, k1=0.1, k2=0.02.
3. Use **Gain** so T_p is the body-x force (e.g. +1 forward): Fx = T_p, Fy = 0, Fz = 0.
4. **Mux** Fx, Fy, Fz into one 3-vector and connect to **Rigid Body Dynamics** "Total External Forces" input; disconnect the original `[0 0 0]`.

Thrust is then wired; add **Torque_SIL** output Q_p to "Total External Moments" when modelling propeller torque.
