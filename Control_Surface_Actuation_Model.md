# Control Surface Actuation Model [WIP!!!!]
**Reference**: These are all summarized explanations from https://drive.google.com/file/d/10iq7L_kAAdkjCFoq4EBRaT1u212BbyJ7/view?pli=1.

*Note that this is done for a standard aircraft configuration for ZeroPilot's M3 and M4. This is not done for a V-tail aircraft.*

#### Aircraft Angles:
| Symbol |	Parameter | Units |
|---|---|---|
| $\phi$ | Roll angle | degrees |
| $\theta$ | Pitch angle | degrees |
| $\psi$ | Yaw angle | degrees |
| $\delta_a$ | Deflection of the ailerons | degrees |
| $\delta_e$ | Deflection of the elevator | degrees |
| $\delta_r$ | Deflection of the rudder | degrees |
| $X$ | Course angle | degrees |
| $\dot{X}$ | Course angular rate about the inertial frame's k axis and $V_a$'s horizontal component | rad/s |
| $\gamma$ | Flight path angle | degrees |
| $$ |  |  |
| $$ |  |  |
<img width="260" height="254" alt="image" src="https://github.com/user-attachments/assets/e20df6de-a537-4971-90b2-e034f5fe3e35" />

#### Other Variables:
| Symbol |	Parameter | Units |
|---|---|---|
| $F_{lift}$ | Life force | N |
| $V_g$ | Ground speed | m/s |
| R | turning radius | m |
| $$ |  |  |
| $$ |  |  |

The positive direction of any control surface's deflection can be determined by applying the right-hand rule to the hinge axis of the control surface (pointing towards the body of the fixed-wing aircraft)!

<img width="359" height="206" alt="image" src="https://github.com/user-attachments/assets/966873eb-a69f-4b36-944b-5f9797c28c16" />

### $\delta_a = \frac{1}{2} (\delta_{a,left} - \delta_{a,right}) $
A positive $\delta_a$ is when the left aileron is trailing edge down and the right aileron is trailing edge up.

## Coordinated Turn
This is when an aircraft is experiencing no lateral acceleration in the body frame, and has a set roll/bank angle, eliminating the net side force acting on the UAV. It allows us to relate course (heading) rate and roll/bank angle, $\phi$.

#### Equation for a Coordinated Turn
### $\dot{X} = \frac{g}{V_g}tan(\phi)cos(X - \psi)$
### $R = V_g cos(\frac{\gamma}{\dot{X}}) = \frac{V_g^{2} cos(\gamma)}{g tan(\phi) cos(X - \psi)}$
In zero wind conditions and no sideslip angle, $V_a = V_g$ and $\psi = X$, therefore:
### $\dot{X} = \frac{g}{V_g} tan(\phi) = \dot{\psi} = \frac{g}{V_a} tan(\phi)$
The above equation for the yaw angle rate also holds true in the presence of wind (through much derivation).

## Trim Conditions
### Defining a trim condition







