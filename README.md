# efs-aircraft-sil
Creating a simulink model of the ZP aircraft.

## MATLAB (from sil.docx)

Formulas from the SIL document are implemented in the `matlab/` folder:

| File | Description |
|------|-------------|
| `thrust_formula.m` | Thrust T = (1/2)ρAv²C_T |
| `thrust_coefficient.m` | C_T = k₁(v/v_tip) + k₂(v/v_tip)² |
| `lift_formula.m` | Lift L = (1/2)ρv²S·C_L |
| `drag_formula.m` | Drag D = (1/2)ρv²S·C_D |
| `pid_attitude.m` | PID: u = Kp·e + Ki·∫e + Kd·de/dt |
| `pid_ziegler_nichols.m` | Ziegler–Nichols initial gains from Ku, Tu |
| `run_sil_demo.m` | Demo script (thrust, aero, PID + plots) |
| `build_sil_simulink.m` | Creates SIL_Formulas.slx with Thrust/Lift/Drag/PID subsystems |
| `sil_set_matlab_function_code.m` | Fills MATLAB Function block code in SIL_Formulas |
| `SIL_Simulink_Block_Code.m` | Code to paste into each MATLAB Function block (if needed) |

**Run demo:** In MATLAB, `cd` to project root, then `run('matlab/run_sil_demo')` or add `matlab` to path and run `run_sil_demo`.

### Simulink (SIL blocks)

1. In MATLAB (project root): `run('matlab/build_sil_simulink')`
2. This creates **SIL_Formulas.slx** with subsystems: **Thrust_SIL**, **Lift_SIL**, **Drag_SIL**, **PID_Attitude_SIL** (each with a MATLAB Function block implementing the formula).
3. Copy these subsystems into **AM_SITL.slx**, or use **Model Reference** to reference `SIL_Formulas`.
4. If the script does not fill the MATLAB Function block code automatically, paste from **matlab/SIL_Simulink_Block_Code.m** into each block (ThrustFcn, LiftFcn, DragFcn, PIDFcn).

### How to add formulas into AM_SITL

1. **Open both models**  
   In MATLAB, open `SIL_Formulas.slx` first, then `AM_SITL.slx` (or open only AM_SITL and drag in from Library Browser or from file).

2. **Drag subsystems into AM_SITL**  
   - In **SIL_Formulas**, select the subsystem **Thrust_SIL** (or Lift_SIL, Drag_SIL, PID_Attitude_SIL), `Ctrl+C` to copy.  
   - Switch to the **AM_SITL** canvas, click in the blank area between “Total External Forces” and “Rigid Body Dynamics” on the left, `Ctrl+V` to paste.  
   - In the same way you can paste **Lift_SIL**, **Drag_SIL** (and **PID_Attitude_SIL** when needed).

3. **Wire the inputs**  
   - **Thrust_SIL** needs: `rho` (air density), `A` (rotor disk area), `v` (airspeed), `v_tip` (tip speed), `k1`, `k2`.  
     - `v` can be computed from **Rigid Body Dynamics** “Body Velocities [u,v,w]” (e.g. sqrt(u^2+v^2+w^2)), or use a Constant for a fixed value when testing.  
     - The rest can be Constants or from Workspace/other blocks.  
   - **Lift_SIL / Drag_SIL** need: `rho`, `v`, `S` (wing area), `C_L` / `C_D` (coefficients; use Constant or lookup table).

4. **Connect formula outputs to rigid body dynamics**  
   - Combine **Thrust_SIL** output `T`, **Lift_SIL** output `L`, and **Drag_SIL** output `D` in body axes into **Total External Forces [Fx, Fy, Fz]**:  
     - e.g. thrust along body forward (x), lift/drag decomposed to x, z by pitch angle θ. Use **Gain**, **Sum**, **Mux** or a small **MATLAB Function** to convert T, L, D to `[Fx; Fy; Fz]`.  
   - Use **Mux** to combine `Fx, Fy, Fz` into one vector and connect it to the “Total External Forces [x, y, z]” input; **disconnect** the original constant `[0 0 0]`.

5. **Moments (optional)**  
   - If using **PID_Attitude_SIL** for attitude control, its output `u` can be treated as actuator/moment commands; use a mapping block to get “Total External Moments [m, n, l]”, connect to **Rigid Body Dynamics** moment input, and disconnect the original constant `[0 0 0]`.

6. **Run the simulation**  
   Set Stop Time, then click **Run**. Use Scope/Display to check that angular rates, attitude, position, etc. look reasonable; then tune `k1`, `k2`, `C_L`, `C_D`, and PID gains as needed.
