# Discretization

Transformation of continuous variables, models or functions or non-discrete objects into a discrete approximation. Discretization is often carried out as very important initial step for many numerical evaluations and modelling process. 

Many Finite element models generally start with a physical model, which we interpret as a mathematical model. Then, discretization break the domain of the model (which could be space or time or both) into many elements (defined by mesh density), define loading and boundary conditions and allows to interpret result and access accuracy easily. We can further refine the mesh and see how the solution changes to get a better result. Computational Fluid Dynamics makes use of different types of discretization schems to get better accuracy models such as Central Differences scheme, upwind scheme and so on.

## Modeling and Discretizing Space and time
Natural processes occurs in space and evolve over time (spatially extended dynamical systems). For example, the temperature of a rod can vary from one end to another end and the temperature can change with time regardless of spatial location. Sometimes the process is stationary (no time evolution) when only spatial variations are considered. 

Both Space and time are discretized for numerical solutions. There are different ways to model spacce and time

Temporal evolutions are generally captured in 
- differential equations where time is continuous. 
- where only discrete time events or only significant moments of interests (eg: time of arrival of guest), such approach is called Discrete-Event Simulation (DES).

Space can be modelled in different ways:
1. Eulerian approach: take the point of view of an observer who sits at a fixed position $\vec x$ in space and records what he sees, i.e. we attach a property of the system at each spatial location. eg: local atmospheric pressure as function of space and time. These are generally used for spacial discretization models
2. Lagrangiane Approach: gives position of all objects of interest as function of time where the observer take the point of view of the moving object.
