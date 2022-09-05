# Scientific Computation with Julia

Scientific Computation is mostly about computational thinking for modelling and simulating the natural processes such as fluid flow in physics, tissue growth in biology, river flow modelling in environmental sciences, stock trends in finance and many other processes.

The world is complex and because of the complexity, we often simplify the real-world problem through an approximation or constrain it under certain assumptions. We use this simplified abstraction or mathematical representation of the phenomena to describe, understand, predict and even control a phenomena more accurately. 

The same system can be described and model at different scales or different level of granularity, and different methods apply depending on the scales we are interested in. One has to identify the essential and relevant components required to model the processes and interactions. Furthermore, the model is not exactly the real world (except in some scenarios like games such as chess, go), there exist discrepancies between the solutions obtained and the realistic solution. Hence, there exist different techniques and efficient algorithms for modeling for different scenarios. Different mathematical concepts and techniques are applied to model real-world processes.

## Table of Contents
- [Intro to Julia Programming](Intro2Julia/readme.md)
- [Data Structure and Algorithms](DSA/readme.md)
- [Calculus](Calculus/readme.md)
- [Optimization](Optimization/readme.md)
- [Linear Algebra](LinearAlgebra/readme.md)
- [Combinatorics](Combinatorics/readme.md)
- [Probability and Statistics](ProbStats/readme.md)
- [Information Theory](InformationTheory/readme.md)
- [Numerical Analysis](NumericalAnalysis/readme.md)
- [Simulations](Simulations/readme.md)
- [Scientific Machine Learning](SciML/readme.md)

Once a model is specified, one need to program it and run or simulate it multiple times to study different numerical results in a computer based virtual environment. The program generated needs to be verified to check if the model is accurately implemented and validated with known benchmark results. This allows us to judge if the models predictions are acceptable in a new situation.

The General workflow becomes

data ⟶  input  ⟶ process ⟶ model ⟶ visualize ⟶ output ⟶ Verify & Validate

Examples of Modelling 
- N-Body Systems, Molecular Dynamics
- Mathematical Equations such as ODE, PDE
- Monte-Carlo Simulations
- Cellular Automata and Lattice Boltzmann Methods
- Multi-agents Systems
- Discrete Events Simulations
- Complex Networks


## Usage Guidelines
This tutorial mostly consist of two types of notebooks. 


### Jupyter Notebooks (.ipynb)
To run the tutorials interactively via Jupyter notebooks, install the package and open the tutorials like:
```
using Pkg
pkg"add https://github.com/rojesh-shikhrakar/DSA.jl"
using IJulia
notebook()
```

### Pluto Notebooks (.jl)
```
using Pkg
pkg"add https://github.com/rojesh-shikhrakar/DSA.jl"
using Pluto
Pluto.run()
```