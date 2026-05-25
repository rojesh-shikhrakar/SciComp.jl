# Numerical Methods and Numerical Analysis

Numerical analysis focuses on design, analysis and use of numerical approximation or estimation techniques to give approximate but accurate solutions to hard problems in many domains such as computing trajectory of spacecrafts and celestial bodies as solution of ordinary differential equations, Stochastic differential equations and markov chain in cellular biology, numerical analysis in quantitative finance and actuarial analysis, optimization techniques applied on ticket pricing in airlines operation research, numerical weather predictions and so on.

Some of the Techniques used are as follows:

- Computation and Error Estimation: When plugging numbers in a formula not efficient, certain techniques are designed to compute values of function more efficiently. eg: Horner's method for polynomial evaluation which was used widely before computer systems.
- Interpolation, extrapolation and Regression are similar techniques to estimate values at point between the given data, outside the given data or when the values are imprecise
- Solving systems of Equations:
  - Linear Equations: many standard direct and iterative methods are developed for solving systems of linear equations
  - Non-Linear Equations: uses root-finding algorithms or Linearisation techniques are used
- Eigen value or Singular Value Problems
- Optimization Problems: seeks to find the maximum or minimum of a given function to satisfy certain constrains. The types of problems can be multi-objective or multi-modal (global optimization). There are many sub-fields of Optimization.
  - Convex Programming studies when the objective functions is convex (minimization) or concave (Maximization) and the constraints are convex. There are many sub types as well such as Linear Programming(LP), Conic Programming, Geometric Programming and so on.
  - Integer Programming (IP): linear programs where some variables are integers values, this is not convex and hence more difficult than regular LP problems.
  - Stochastic Programming: cases where some constraints or parameters depends on random variables
  - Robust optimization: attempts to capture uncertainty in the data underlying the optimization problems
  - Heuristic and Metaheuristic makes few or no assumptions about the problems. They usually do not guarantee to find any optimal solution but are used to find approximate solutions for many complicate problems
  - Constraint Satisfaction are studied mostly as a part of AI and studies a case in which the objective function f is constant.
  - Evolutionary Algorithms, Bayesian Optimization, simulated Annealing techniques are used for global optimization where multiple local extrema may be present.
- Numerical Differential Equations: computes solution to differential equations for both ODE and PDE. This can be done in different methods which are theoretically justified from functional analysis.
  - Finite Element Methods
  - Finite Difference Methods
  - Finite Volume Methods
- Numerical Integration (Numerical Quadrature): solves hard to solve integration problems numerically