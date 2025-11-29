# Scientific Computation

This book is about computational thinking and solving problems that involves computers for modelling, simulating, analyzing the natural and artificial phenomena and complex systems across a wide range of domain. Computational thinking can help us to formulate problems, express solutions, and analyze the outcomes using computational tools and methods.

The world is complex. Hence, we often simplify the real-world problem using some approximations or constraints based on certain assumptions. We can describe and model a system at different level of granularity (scales) based on the system of interest; a different method might be required to describe and analyze the model at different scales. We use this simplified abstraction or mathematical representation of the phenomena to describe, understand, predict and even control a phenomena more accurately. Because of the simplification, the model is not exactly reflect the real world (except in some scenarios like games such as chess, go). There may exist certain discrepancies between the solutions obtained and the realistic solution.

Hence the major themes are

- Representation: encoding information about the world in a computer or a mathematical form to formulate the problem. Usually the choices in representation affect the ease with which we can solve problems.
  - Generalization/Abstraction : common properties and rules are derived as general concepts
- Decomposition: breaking a large and diverse problem into many simpler parts
  - Discretization: break up space and time into a large number of relatively small pieces
- Data Science : drawing conclusion from large and diverse data sets through exploration, prediction and inference, with statistics and visualization
  - Exploration & Pattern Recognition: identify patterns and irregularities in data
  - Prediction: make informed guess about values
  - Inference: quantify degree of certainty about our hypothesis or prediction
- Analysis: solution of the problem and evaluation
  - Verification: Ensures the model (or system) is implemented correctly according to its design and specifications. Focuses on internal consistency, correctness of algorithms, code, and logic. Builds confidence in the correctness of the model’s implementation.
    - Checking that your Python simulation of fluid dynamics solves the equations correctly (no coding errors, numerical methods are stable).
  - Validation: Ensures the model is appropriate and accurate for its intended real-world purpose. Focus on external accuracy,  does the model’s output match reality or stakeholder expectations? Builds confidence in the usefulness of the model for decision-making or prediction.
    - Comparing the simulation results against experimental data to confirm it reflects real fluid behavior.