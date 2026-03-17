# efs-aircraft-sil
Creating a simulink model of the ZP aircraft.

## Forces on the Aircraft
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

#### Constants specific to ZeroPilot:
| Symbol |	Paramater	     | Units |
|---|---|---|
| $\rho$ | Air density	   |       |
| $V_a$	   | Airspeed of UAV |	     |
| S	| Platform wing area	| |
| $\alpha$ | Angle of attack | Degrees |
| c	| Mean chord length	| |
| q	| Pitch rate	| rad/s |
| $\delta_e$	| Elevator deflection	| Degrees |

#### Coefficients of the Aerosonde
| Symbol |	Paramater	     | Units |
|---|---|---|

### Longitudinal Aerodynamic Force:
### $$F_{lift_{longitudinal}} = \frac{1}{2} \rho V_a^2S * [C_L(\alpha) +C_{L_q}\frac{c}{2V_a}q + C_{L_{{\delta}_e}}\delta_e] $$
