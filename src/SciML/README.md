# Scientific Machine Learning

Engineering systems can be very complex, but we can always model something about them, there are certain known parameters that we have measured and are confident about such as acceleration due to gravity or density of air at the sea level, and there are certain parameters that we know but we have not or are unable to measure like operating conditions of a vehicle, fluid flow pressure on an surface and so on. Predictive modeling is the process of describing our state of knowledge about these known unknowns in order to make informed decisions.

For thousands of years, scientific inquiry has been **empirical**; scientist observe and attempt to replicate the natural world in a controlled environment and record the observations. Later scientists started formalizing these natural phenomena using **theoretical** models as a valid method of inquiry. These theoretical causal models explains many of the observed behaviors as well as expands the scientific knowledge by suggesting new experiments. Theories and experiments have been the two foundational pillars of science for our understanding of the universe. With the advent of computer systems, and high speed **computation** capabilities, scientist can simulate complex systems that cannot be directly observed or reproduced even at the scale of universe or at the quantum realm. Furthermore, we can use computer algorithms to analyze the massive amount of data captured through variety of sensors in high velocity. Survey telescope producing large petabytes of high resolution images of space or high-throughput sequencers used in life sciences are some examples. Availability of data, computation resources and advanced algorithms has made it possible to work on highly non-linear and complex data analysis feasible. We can further leverage the scientific knowledge and theory for improving the performance, interpretability and effectiveness of the **data science** models. Yet most data science models are "black box" models that does not take into account existing theory about the process. Hence, there's a new domain of data science called theory guided data science that use theory to guide the model.

The scientific method has evolved from Experimentation to Theoretical to Computation to Data Science and theory guided data science.

SciML Ecosystem in Julia

- DifferentialEquations.jl: High-performance differential equation solvers
- DiffEqFlux.jl: Universal Differential Equation Training Optimizer, sensitivity analysis and layer functions
- ModelingToolkit.jl: symbolic-numeric optimizations and automated parallelism
- DataDrivenDiffEq.jl: Koopman Dynamic Mode Decomposition (DMD) methods and sparse identification (SinDy)
- NeuralPDE.jl: NN solver for PDEs including automated PINN and deep BSDE methods for high dimensional PDEs
- Catalyst.jl: high-performance differentiable modelling of chemical reaction networks
- NBodySimulator.jl: high-performance differentiable molecular dynamics
- Flux.jl, Zygote.jl, SparseDiffTools.jl, etc

## References

- [Predictive Science Lab, U Purdue](https://www.predictivesciencelab.org/) and [git repo](https://github.com/PredictiveScienceLab)
- [Physics-based Deep Learning](https://physicsbaseddeeplearning.org/intro.html)
- [Machine Learning for Physicists](https://pad.gwdg.de/s/Machine_Learning_For_Physicists_2021)
- [Theory-guided Data Science](https://arxiv.org/abs/1612.08544)
- [Judea Peal - Causality](http://bayes.cs.ucla.edu/jp_home.html)
