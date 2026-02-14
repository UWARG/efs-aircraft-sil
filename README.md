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

### 如何把公式加进 AM_SITL

1. **打开两个模型**  
   在 MATLAB 里先打开 `SIL_Formulas.slx`，再打开 `AM_SITL.slx`（或只开 AM_SITL，从 Library Browser 或从文件拖入）。

2. **把子系统拖进 AM_SITL**  
   - 在 **SIL_Formulas** 里选中子系统 **Thrust_SIL**（或 Lift_SIL、Drag_SIL、PID_Attitude_SIL），`Ctrl+C` 复制。  
   - 切到 **AM_SITL** 画布，在左侧 “Total External Forces” 和 “Rigid Body Dynamics” 之间空白处点一下，`Ctrl+V` 粘贴。  
   - 同样方式可把 **Lift_SIL**、**Drag_SIL** 贴进来（需要时再贴 **PID_Attitude_SIL**）。

3. **接好输入信号**  
   - **Thrust_SIL** 需要：`rho`（大气密度）、`A`（桨盘面积）、`v`（空速）、`v_tip`（桨尖速度）、`k1`、`k2`。  
     - `v` 可从 **Rigid Body Dynamics** 的 “Body Velocities [u,v,w]” 算空速（例如 sqrt(u^2+v^2+w^2)），或先用 Constant 给固定值测试。  
     - 其余可用 Constant 或来自 Workspace/其他块。  
   - **Lift_SIL / Drag_SIL** 需要：`rho`、`v`、`S`（机翼面积）、`C_L` / `C_D`（系数，可用 Constant 或查表）。

4. **把公式输出接到刚体动力学**  
   - 把 **Thrust_SIL** 的 `T`、**Lift_SIL** 的 `L`、**Drag_SIL** 的 `D` 按机体轴系合成为 **Total External Forces [Fx, Fy, Fz]**：  
     - 例如：推力沿机体前向（如 x），升力/阻力按俯仰角 θ 分解到 x、z。可用 **Gain**、**Sum**、**Mux** 或一个小 **MATLAB Function** 把 T、L、D 转成 `[Fx; Fy; Fz]`。  
   - 用 **Mux** 把 `Fx, Fy, Fz` 合成一路向量，接到 “Total External Forces [x, y, z]” 的输入，**断开**原来接的常数 `[0 0 0]`。

5. **力矩（可选）**  
   - 若用 **PID_Attitude_SIL** 做姿态控制，其输出 `u` 可视为舵面/力矩指令，再通过一个映射块得到 “Total External Moments [m, n, l]”，接到 **Rigid Body Dynamics** 的力矩输入，并断开原来的常数 `[0 0 0]`。

6. **运行仿真**  
   设置好 Stop Time 后点 **Run**，用 Scope/Display 看角速率、姿态、位置等是否合理；再根据需要调 `k1`、`k2`、`C_L`、`C_D` 和 PID 增益。
