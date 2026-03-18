# efs-aircraft-sil
Creating a simulink model of the ZP aircraft.

## Forces & Moments on the Aircraft
Sum of Forces acting on the Airframe is equal to:
<p align="center">
$f = f_g^{body} + f_a^{body} + f_p^{body}$
</p>

Where:
- $f_g$ = gravitational force
- $f_a$ = aerodynamic force
- $f_p$  = propulsive force
Which are all calculated in the body frame.

#### Gravitational Force:
<p align="center">
$$ f_g^{body} = R^b_v * f^{vehicle}_g = R^b_v * \begin{pmatrix} 0 \\ 0 \\ mg \end{pmatrix} $$
</p>
Where $R^b_v$ is the rotational matrix defined earlier used to transform the vehicle frame gravitational force into one calculated within the body frame. Applying that, we get:
<p align="center">
$$ f_g^{body} = mg * \begin{pmatrix} -sin(\theta) \\ cos(\theta)sin(\phi) \\ cos(\theta)cos(\phi) \end{pmatrix} $$
</p>

### Aerodynamic Constants
Since these will be to used to solve for the aerodynamic forces and moments, it will be useful to define these beforehand.

Note that the mean chord length, wingspan and wing area were scaled by the RV-12iS's dimensions by a geometric scale factor of gsf = 1/8.

#### Constants specific to ZeroPilot:
| Symbol |	Paramater | Value | Units |
|---|---|---|---|
| gsf | Geometric scale factor for parameters derived from RV-12is | $1/8.02$ | – |
| $\rho$ | Air density | 1.225 | $kg/m^3$ |
| c	| Mean chord length	| 7.045 | m |
| b |	Wingspan | 40.025 | m |
| S	| Wing area	| 0.184 | $m^2$ |
| $A_R$	| Wing Aspect Ratio	| $b^2/S = 8750.085$ | – |

### Other constants taken from the Aerosonde
| Symbol |	Paramater | Value | Units |
|---|---|---|---|
| M | Mach number | 50 | – |
| $\alpha_0$ | Initial angle of attack	| 0.47 | Degrees |
| e | Oswald efficiency factor | 0.9 | – |

#### Longitudinal Coefficients of the Aerosonde for Force Calculations
| Symbol | Paramater | Value |
|---|---|---|
| $C_{L_0}$ | Initial Lift Coefficient | 0.23 |
| $C_{D_0}$ | Initial Drag Coefficient | 0.0424 |
| $C_{L_q}$ | Lift coeff. derivative w.r.t to pitch rate, q | 7.95 |
| $C_{L_{{\delta}_e}}$ | Lift elevator control derivative | 0.13 |
| $C_{D_q}$ | Drag coefficient derivative w.r.t to pitch rate, q | 0 |
| $C_{D_{{\delta}_e}}$ | Drag elevator control derivative | 0.0135 |

#### Longitudinal Coefficients of the Aerosonde for Moment Calculations
| Symbol | Paramater | Value |
|---|---|---|
| $C_{m_0}$ | Pitching moment coefficient at zero angle of attack | 0.0135 |
| $C_{m_\alpha}$ | Pitching stability derivative w.r.t angle of attack, $\alpha$ | -2.74 |
| $C_{m_q}$ | Pitching stability derivative w.r.t pitch rate | -38.21 |
| $C_{m_{\delta}_e}}$ | Pitching moment due to elevator deflection, $\delta_e$ | -0.99 |

#### Lateral Coefficients of the Aerosonde for Force Calculations
| Symbol | Paramater | Value |
|---|---|---|
| $C_{Y_0}$ | Asymmetric side force coefficient | 0 |
| $C_{Y_\beta}$ | Side-force stability derivative w.r.t sideslip angle | -0.83 |
| $C_{Y_r}$ | Side-force dynamic derivative w.r.t yaw rate | 0 |
| $C_{Y_{{\delta}_a}}$ | Side-force control derivative due to aileron deflection | 0.17 |
| $C_{Y_{{\delta}_r}}$ | Side-force control derivative due to rudder deflection | 0.19 |

#### Lateral Coefficients of the Aerosonde for Moment Calculations
| Symbol | Paramater | Value |
|---|---|---|
| $C_{l_0}$ | Roll coefficient at zero sideslip | 0 | 
| $C_{l_\beta}$ | Dihedral effect (Roll derivative due to sideslip | -0.13 | 
| $C_{l_p}$ | Roll damping derivative w.r.t roll rate | -0.51 | 
| $C_{l_r}$ | Roll derivative w.r.t yaw rate | 0.25 | 
| $C_{l_{{\delta}_a}}$ | Rolling derivative w.r.t aileron deflection, $\delta_a$ | 0.17 | 
| $C_{l_{{\delta}_r}}$ | Rolling derivative w.r.t rudder deflection, $\delta_r$ | 0.0024 |
| $C_{n_0}$ | Yaw coefficient at zero sideslip | 0 | 
| $C_{n_\beta}$ | Yaw derivative w.r.t sideslip (Weathercock stability) | 0.073 | 
| $C_{n_p}$ | Adverse yaw derivative w.r.t roll rate | -0.069 | 
| $C_{n_r}$ | Yaw damping derivative w.r.t yaw rate | -0.095 | 
| $C_{n_{{\delta}_a}}$ | Yaw derivative w.r.t aileron deflection, $\delta_a$ | -0.011 | 
| $C_{n_{{\delta}_r}}$ | Yaw derivative w.r.t rudder deflection, $\delta_r$ | -0.069| 

### Longitudinal Aerodynamics
Variables:
| Symbol |	Paramater	| Units |
|---|---|---|
| $V_a$	   | Airspeed of UAV | m/s |
| q	| Pitch rate	| rad/s |
| $\alpha$ | Angle of attack | Degrees |
| $\delta_e$	| Elevator deflection	| Degrees |

#### Force:
### $$F_{lift_{longitudinal}} = \frac{1}{2} \rho V_a^2S * [C_L(\alpha) +C_{L_q}\frac{c}{2V_a}q + C_{L_{{\delta}_e}}\delta_e] $$

Where:
- $C_{L_\alpha}$ is the linear lift coefficient and can be calculated as: 
  ### $$C_{L_\alpha} = \frac{\pi A_R}{1+\sqrt{1+(\frac{A_R}{2})^2}}$$
- 

### Moment:


### Lateral Aerodynamics
Variables:
| Symbol |	Paramater	| Units |
|---|---|---|
| $\beta$	| Sideslip angle | degrees |
| p	| Roll rate	| rad/s |
| r	| Yaw rate | rad/s |
| $\delta_a$ | Deflection of the aileron | degrees |
| $\delta_r$ | Deflection of the rudder | degrees |

#### Force:

Where:
- $C_{D_i}$ is the induced drag coefficient and can be calculated as:
  ### $$C_{D_i} = (C_l^2) / (pi * A_R * e)$$

#### Moment:











